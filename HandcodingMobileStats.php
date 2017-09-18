<?php

namespace HandcodingMobileStats;

use Enlight_Controller_ActionEventArgs;
use Shopware\Components\Plugin;
use Symfony\Component\DependencyInjection\ContainerBuilder;

/**
 * Shopware-Plugin HandcodingMobileStats.
 */
class HandcodingMobileStats extends Plugin
{

    /**
    * @param ContainerBuilder $container
    */
    public function build(ContainerBuilder $container)
    {
        $container->setParameter('handcoding_mobile_stats.plugin_dir', $this->getPath());
        parent::build($container);
    }

    public static function getSubscribedEvents()
    {
        return [
            'Enlight_Controller_Action_PreDispatch_Widgets' => 'registerTemplate',
        ];
    }

    public function registerTemplate(Enlight_Controller_ActionEventArgs $args)
    {
        $this->container->get('template')->addTemplateDir(__DIR__ . '/Resources/Views/');
    }
}
