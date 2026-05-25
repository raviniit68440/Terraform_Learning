variable "resource_group"{
    default={"rg1"="westeurope"}
}

variable "event_hubnamespace"{
    default="eventhub"
}

variable "evenhubname"{
    default="acceptanceTestEventHub"
}

variable "partition_count"{
    default=2
}
variable "message_retention" {
    default=1
}