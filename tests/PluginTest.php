<?php

namespace HandcodingMobileStats\Tests;

use HandcodingMobileStats\HandcodingMobileStats as Plugin;
use Shopware\Components\Test\Plugin\TestCase;

class PluginTest extends TestCase
{
    protected static $ensureLoadedPlugins = [
        'HandcodingMobileStats' => []
    ];

    public function testCanCreateInstance()
    {
        /** @var Plugin $plugin */
        $plugin = Shopware()->Container()->get('kernel')->getPlugins()['HandcodingMobileStats'];

        $this->assertInstanceOf(Plugin::class, $plugin);
    }
}
