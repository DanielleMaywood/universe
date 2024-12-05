/*************************************************
*                                                *
*            ZONE: daniellemaywood.uk            *
*                                                *
*************************************************/

resource "cloudflare_zone" "daniellemaywood_uk" {
  account_id = var.cf_account_id
  zone       = "daniellemaywood.uk"
}

resource "cloudflare_record" "daniellemaywood_uk_CNAME_pages" {
  zone_id = cloudflare_zone.daniellemaywood_uk.id
  name    = "daniellemaywood.uk"
  value   = cloudflare_pages_project.home.subdomain
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "daniellemaywood_uk_TXT_google" {
  zone_id = cloudflare_zone.daniellemaywood_uk.id
  name    = "daniellemaywood.uk"
  value   = "google-site-verification=VDJzEVRpRsxmJv0OXBIsvJTp0Xa1PwdYihMH47VDx7A"
  type    = "TXT"
}

resource "cloudflare_record" "_atproto_daniellemaywood_uk_TXT_bsky" {
  zone_id = cloudflare_zone.daniellemaywood_uk.id
  name    = "_atproto"
  value   = "did=did:plc:b4wthggvovz2uwoet47bstfp"
  type    = "TXT"
}

/*************************************************
*                                                *
*            PAGE: daniellemaywood.uk            *
*                                                *
*************************************************/

resource "cloudflare_pages_project" "home" {
  account_id        = var.cf_account_id
  name              = "daniellemaywood"
  production_branch = "prod"
}

resource "cloudflare_pages_domain" "daniellemaywood_uk" {
  account_id   = var.cf_account_id
  project_name = cloudflare_pages_project.home.name
  domain       = cloudflare_zone.daniellemaywood_uk.zone
}
