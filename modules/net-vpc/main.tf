resource "google_compute_network" "gpc_bootcamp_net" {
  name                    = "bootcamp-net"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "gcp_bootcamp_subnet" {
  depends_on = [
    google_compute_network.gpc_bootcamp_net
  ]
  name          = "bootcamp-subnet"
  ip_cidr_range = "10.1.1.0/24"
  network       = google_compute_network.gpc_bootcamp_net.self_link
  region        = var.gcp_region
}
