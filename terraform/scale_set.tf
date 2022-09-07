data "azurerm_image" "example" {
  name                = var.image_name
  resource_group_name = "UDACITY-AZUREDEVOPS"
}

resource "azurerm_linux_virtual_machine_scale_set" "example" {
  name                = "${var.prefix}-VMSS"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Standard_D2s_v3"
  instances           = var.minimum_instance
  admin_username      = var.username
  admin_password      = var.password

  admin_ssh_key {
    username   = var.username
    public_key = local.public_key
  }

  source_image_id = data.azurerm_image.example.id

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name                      = "${var.prefix}-nic"
    primary                   = true
    network_security_group_id = azurerm_network_security_group.example.id

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.example.id
      load_balancer_backend_address_pool_ids = [
        azurerm_lb_backend_address_pool.example.id
      ]
      public_ip_address {
        name              = "PublicIPForInstance"
        domain_name_label = var.prefix
      }
    }
  }
  tags = local.tags
}

resource "azurerm_monitor_autoscale_setting" "example" {
  name                = "${var.prefix}-AutoscaleSetting"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.example.id

  profile {
    name = "defaultProfile"

    capacity {
      default = var.minimum_instance
      minimum = var.minimum_instance
      maximum = var.maximum_instance
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.example.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
        metric_namespace   = "microsoft.compute/virtualmachinescalesets"
        dimensions {
          name     = "AppName"
          operator = "Equals"
          values   = ["App1"]
        }
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.example.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }

  notification {
    email {
      send_to_subscription_administrator    = true
      send_to_subscription_co_administrator = true
      custom_emails                         = ["ngodaisonn@gmail.com"]
    }
  }
  tags = local.tags
}