<?php

/**
 * {@inheritDoc}
 */
class Shopware_Controllers_Widgets_Stats extends \Enlight_Controller_Action
{
    public function indexAction()
    {
        $config = $this->container->get('shopware.plugin.cached_config_reader')->getByPluginName('HandcodingMobileStats');

        if ($config['Token'] === 'MobileStats') {
            $this->response->setHttpResponseCode(403);
            $this->response->setBody('Please define a token in the HandcodingMobileStats-Plugin config.');
            $this->View()->loadTemplate('widgets/stats/error.tpl');
        } elseif (!empty($config['Token']) &&
            $config['Token'] !== $this->Request()->getParam('token')) {
            $this->response->setHttpResponseCode(403);
            $this->response->setBody('The token you provided is wrong. You can provide a token using the ?token=<your-token> parameter.');
            $this->View()->loadTemplate('widgets/stats/error.tpl');
        }

        $shop = $this->get('shopware_storefront.context_service')->getShopContext()->getShop();

        $startDate = $this->Request()->getParam('fromDate', date('Y-m-d', mktime(0, 0, 0, date('m'), 1, date('Y'))));
        $toDate = $this->Request()->getParam('toDate', date('Y-m-d'));

        $orders = $this->get('handcoding.mobilestats.service.stats')->getOrders(
            $startDate,
            $toDate
        );

        $this->View()->assign('shop', $shop);
        $this->View()->assign('orders', $orders);
    }
}
