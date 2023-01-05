terraform {
    required_providers {
        ct = {
            source = "poseidon/ct"
            version = "0.11.0"
        } 
        local = {
            source = "hashicorp/local"
        }
    }
}
