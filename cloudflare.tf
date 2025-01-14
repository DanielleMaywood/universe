/*************************************************
*                                                *
*            ZONE: tea.hut                       *
*                                                *
*************************************************/

resource "cloudflare_zone" "tea_ht" {
  account_id = var.cf_account_id
  zone       = "tea.ht"
}

resource "cloudflare_record" "tea_ht_A" {
  zone_id = cloudflare_zone.tea_ht.id
  name    = "tea.ht"
  content = var.winnie.a
  type    = "A"
  proxied = false
}

resource "cloudflare_record" "tea_ht_AAAA" {
  zone_id = cloudflare_zone.tea_ht.id
  name    = "tea.ht"
  content = var.winnie.aaaa
  type    = "AAAA"
  proxied = false
}

/*************************************************
*                                                *
*            ZONE: daniellemaywood.uk            *
*                                                *
*************************************************/

resource "cloudflare_zone" "daniellemaywood_uk" {
  account_id = var.cf_account_id
  zone       = "daniellemaywood.uk"
}

resource "cloudflare_zone_dnssec" "daniellemaywood_uk" {
  zone_id = cloudflare_zone.daniellemaywood_uk.id
}

resource "cloudflare_bot_management" "daniellemaywood_uk" {
  zone_id            = cloudflare_zone.daniellemaywood_uk.id
  ai_bots_protection = "block"
  fight_mode         = false
}

resource "cloudflare_record" "daniellemaywood_uk_CNAME_pages" {
  zone_id = cloudflare_zone.daniellemaywood_uk.id
  name    = "daniellemaywood.uk"
  content = cloudflare_pages_project.home.subdomain
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "daniellemaywood_uk_TXT_google" {
  zone_id = cloudflare_zone.daniellemaywood_uk.id
  name    = "daniellemaywood.uk"
  content = "google-site-verification=VDJzEVRpRsxmJv0OXBIsvJTp0Xa1PwdYihMH47VDx7A"
  type    = "TXT"
}

resource "cloudflare_record" "_atproto_daniellemaywood_uk_TXT_bsky" {
  zone_id = cloudflare_zone.daniellemaywood_uk.id
  name    = "_atproto"
  content = "did=did:plc:b4wthggvovz2uwoet47bstfp"
  type    = "TXT"
}

resource "cloudflare_record" "daniellemaywood_uk_A_chef" {
  zone_id = cloudflare_zone.daniellemaywood_uk.id
  name    = "chef"
  content = var.winnie.a
  type    = "A"
  proxied = false
}

resource "cloudflare_record" "daniellemaywood_uk_AAAA_chef" {
  zone_id = cloudflare_zone.daniellemaywood_uk.id
  name    = "chef"
  content = var.winnie.aaaa
  type    = "AAAA"
  proxied = false
}

resource "cloudflare_record" "daniellemaywood_uk_A_coder" {
  zone_id = cloudflare_zone.daniellemaywood_uk.id
  name    = "coder"
  content = var.winnie.a
  type    = "A"
  proxied = false
}

resource "cloudflare_record" "daniellemaywood_uk_AAAA_coder" {
  zone_id = cloudflare_zone.daniellemaywood_uk.id
  name    = "coder"
  content = var.winnie.aaaa
  type    = "AAAA"
  proxied = false
}

/*************************************************
*                                                *
*            PAGE: daniellemaywood.uk            *
*                                                *
*************************************************/

resource "cloudflare_pages_project" "home" {
  account_id        = var.cf_account_id
  name              = "daniellemaywood"
  production_branch = "main"

  build_config {
    build_command   = "npm run build"
    destination_dir = "dist"
  }

  source {
    type = "github"

    config {
      owner     = "DanielleMaywood"
      repo_name = "daniellemaywood.uk"

      production_branch             = "main"
      production_deployment_enabled = true
    }
  }

  deployment_configs {
    production {}
  }
}

resource "cloudflare_pages_domain" "daniellemaywood_uk" {
  account_id   = var.cf_account_id
  project_name = cloudflare_pages_project.home.name
  domain       = cloudflare_zone.daniellemaywood_uk.zone
}
