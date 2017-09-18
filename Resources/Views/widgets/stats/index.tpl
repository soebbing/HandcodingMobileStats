<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=0.5, shrink-to-fit=yes">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <div class="col">
            <h1>Statistiken für {$shop->getName()}</h1>
        </div>
    </div>

    <div class="row">
        <main class="col-md">
        {if $orders|count === 0}
            <h3>Keine Daten verfügbar</h3>
            {else}
            <div class="table-responsive">

                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>Datum</th>
                        <th>Umsatz</th>
                        <th>📦</th>
                        <th>Ø&nbsp;Bestellwert</th>
                        <th>Ø&nbsp;Besucher/Bestellung</th>
                        <th>🆕&nbsp;&nbsp;Benutzer</th>
                        <th>🆕&nbsp;&nbsp;Kunden</th>
                        <th title="Besucher">Besucher</th>
                        <th title="Seitenzugriffe">Seitenzugriffe</th>
                    </tr>
                    </thead>
                    <tbody>
                    {foreach from=$orders item=order name="orders"}
                        <tr>
                            <td scope="row">{$order.date|date_format}</td>
                            <td>
                                {if !$smarty.foreach.orders.iteration.last}
                                    {if $orders[$smarty.foreach.orders.iteration].amount < $order.amount}
                                        <span style="color: green">↗</span>
                                    {elseif $orders[$smarty.foreach.orders.iteration].amount == $order.amount}
                                        <span style="color: yellowgreen">→</span>
                                    {else}
                                        <span style="color: red">↘</span>
                                    {/if}
                                {else}
                                    <span style="color: white">→</span>
                                {/if}
                                {number_format($order.amount, 2, ',', '.')}&nbsp;{$shop->getCurrency()->getCurrency()}
                            </td>
                            <td>
                                {if !$smarty.foreach.orders.iteration.last}
                                    {if $orders[$smarty.foreach.orders.iteration].countOrders < $order.countOrders}
                                        <span style="color: green">↗</span>
                                    {elseif $orders[$smarty.foreach.orders.iteration].countOrders == $order.countOrders}
                                        <span style="color: yellowgreen">→</span>
                                    {else}
                                        <span style="color: red">↘</span>
                                    {/if}
                                {else}
                                    <span style="color: white">→</span>
                                {/if}
                                {$order.countOrders}
                            </td>
                            <td>
                                {if !$smarty.foreach.orders.iteration.last}
                                    {if $orders[$smarty.foreach.orders.iteration].averageOrders < $order.averageOrders}
                                        <span style="color: green">↗</span>
                                    {elseif $orders[$smarty.foreach.orders.iteration].averageOrders == $order.averageOrders}
                                        <span style="color: yellowgreen">→</span>
                                    {else}
                                        <span style="color: red">↘</span>
                                    {/if}
                                {else}
                                    <span style="color: white">→</span>
                                {/if}
                                {number_format($order.averageOrders, 2, ',', '.')}&nbsp;{$shop->getCurrency()->getCurrency()}
                            </td>
                            <td>
                                {if !$smarty.foreach.orders.iteration.last}
                                    {if $orders[$smarty.foreach.orders.iteration].visits < $order.visits}
                                        <span style="color: green">↗</span>
                                    {elseif $orders[$smarty.foreach.orders.iteration].visits == $order.visits}
                                        <span style="color: yellowgreen">→</span>
                                    {else}
                                        <span style="color: red">↘</span>
                                    {/if}
                                {else}
                                    <span style="color: white">→</span>
                                {/if}
                                {$order.visits}
                            </td>
                            <td>
                                {if !$smarty.foreach.orders.iteration.last}
                                    {if $orders[$smarty.foreach.orders.iteration].users < $order.users}
                                        <span style="color: green">↗</span>
                                    {elseif $orders[$smarty.foreach.orders.iteration].users == $order.users}
                                        <span style="color: yellowgreen">→</span>
                                    {else}
                                        <span style="color: red">↘</span>
                                    {/if}
                                {else}
                                    <span style="color: white">→</span>
                                {/if}
                                {$order.users|string_format:"%.0d"}
                            </td>
                            <td>
                                {if !$smarty.foreach.orders.iteration.last}
                                    {if $orders[$smarty.foreach.orders.iteration].customers < $order.customers}
                                        <span style="color: green">↗</span>
                                    {elseif $orders[$smarty.foreach.orders.iteration].customers == $order.customers}
                                        <span style="color: yellowgreen">→</span>
                                    {else}
                                        <span style="color: red">↘</span>
                                    {/if}
                                {else}
                                    <span style="color: white">→</span>
                                {/if}
                                {$order.customers|string_format:"%.0d"}
                            </td>
                            <td>
                                {if !$smarty.foreach.orders.iteration.last}
                                    {if $orders[$smarty.foreach.orders.iteration].visits < $order.visits}
                                        <span style="color: green">↗</span>
                                    {elseif $orders[$smarty.foreach.orders.iteration].visits == $order.visits}
                                        <span style="color: yellowgreen">→</span>
                                    {else}
                                        <span style="color: red">↘</span>
                                    {/if}
                                {else}
                                    <span style="color: white">→</span>
                                {/if}
                                {$order.visits}
                            </td>
                            <td>
                                {if !$smarty.foreach.orders.iteration.last}
                                    {if $orders[$smarty.foreach.orders.iteration].hits < $order.hits}
                                        <span style="color: green">↗</span>
                                    {elseif $orders[$smarty.foreach.orders.iteration].hits == $order.hits}
                                        <span style="color: yellowgreen">→</span>
                                    {else}
                                        <span style="color: red">↘</span>
                                    {/if}
                                {else}
                                    <span style="color: white">→</span>
                                {/if}
                                {$order.hits}
                            </td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
            </div>
        {/if}
        </main>
    </div>
</div>
<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
-->
</body>
</html>
