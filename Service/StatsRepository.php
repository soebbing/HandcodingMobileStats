<?php

namespace HandcodingMobileStats\Service;

use Doctrine\DBAL\Connection;

class StatsRepository
{
    /**
     * @var Connection
     */
    private $connection;

    /**
     * @param Connection $connection
     */
    public function __construct(Connection $connection)
    {
        $this->connection = $connection;
    }

    /**
     * @param string $startDate
     * @param string $endDate
     * @return array
     *
     * @throws \Doctrine\DBAL\DBALException
     */
    public function getOrders($startDate, $endDate)
    {
        $sql = '
            SELECT
                SUM(visitors.uniquevisits) AS visits,
                SUM(visitors.uniquevisits)/SUM(order_count.order_count) AS averageUsers,
                SUM(visitors.pageimpressions) AS hits,
                order_count.order_count AS countOrders,
                customer_count.new_customer_count AS countUsers,
                customer_count.new_customer_order_count AS countCustomers,
                order_amount.amount AS amount,
                visitors.datum AS `date`
            FROM s_statistics_visitors AS visitors
            LEFT OUTER JOIN
            (
                SELECT
                    COUNT(DISTINCT id) AS order_count,
                    DATE (ordertime) AS order_date
                FROM s_order
                WHERE status NOT IN (-1, 4)
                GROUP BY DATE (order_date)
            ) AS order_count
            ON order_count.order_date = visitors.datum
            LEFT OUTER JOIN
            (
                SELECT
                    SUM(invoice_amount/currencyFactor) AS amount,
                    DATE (ordertime) AS order_date
                FROM s_order
                WHERE status NOT IN (-1, 4)
                GROUP BY DATE (order_date)
            ) AS order_amount
            ON order_amount.order_date = visitors.datum
            LEFT OUTER JOIN
            (
                SELECT
                    COUNT(DISTINCT s_user.id) AS new_customer_count,
                    COUNT(DISTINCT s_order.id) AS new_customer_order_count,
                    firstlogin AS first_login_date
                FROM s_user
                LEFT JOIN s_order ON s_order.userID = s_user.id
                    AND (DATE(s_order.ordertime) = DATE(s_user.firstlogin))
                    AND s_order.status NOT IN (-1, 4)
                GROUP BY first_login_date
            ) AS customer_count
            ON customer_count.first_login_date = visitors.datum
            WHERE visitors.datum <= :endDate
                AND visitors.datum >= :startDate
            GROUP BY TO_DAYS(visitors.datum)
            ORDER BY visitors.datum DESC
        ';

        $stmt = $this->connection->executeQuery($sql, [
            'endDate' => $endDate,
            'startDate' => $startDate,
        ]);

        $orders = [];

        while ($order = $stmt->fetch()) {
            foreach ($order as $key => $value) {
                if (empty($value)) {
                    $order[$key] = 0;
                }
            }
            if ($order['countOrders'] !== 0) {
                $order['averageOrders'] = $order['amount'] / $order['countOrders'];
            } else {
                $order['averageOrders'] = 0;
            }
            $order['amount'] = round($order['amount'], 2);
            $orders[] = $order;
        }

        return $orders;
    }
}
