data "google_container_engine_versions" "cluster_version" {
  location       = "us-central1-a"
}

provider "google" {
  credentials = "${file("./fuchicorp-service-account.json")}" #GOOGLE_CREDENTIALS to the path of a file containing the credential JSON
  project     = "${var.google_project_id}"
  region      = "${var.region}"
}


resource "google_container_cluster" "tunscotech-cluster" {
  name               = "${var.cluster_name}"
  network            = "default"
  subnetwork         = "default"
  location             = "${var.region}"
  min_master_version = "${data.google_container_engine_versions.cluster_version.latest_node_version}"
  initial_node_count = "${var.node_count}"
  project            = "${var.google_project_id}"
  node_config {
    machine_type = "n1-standard-2"
  }
}
