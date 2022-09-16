# TODO-2207202029: If you're here, you are probably wondering why this bucket does not
# follow our naming convention. The reason is that for divesting this bucket, we need
# to manually add credit cards to all accounts whose state are store in the bucket.
# Whevener this issue is solved, just switch to the commented variables.
#bucket  = "csi-htr-tst.001-aws-accounts-remote-bucket.terraform-state"
bucket         = "csi-htr-tst.002-aws-accounts-remote-bucket.terraform-state"
#key            = "csi-htr-tst-001-aws-accounts/terraform.tfstate"
key            = "csi-htr-tst-002-aws-accounts/terraform.tfstate"
region         = "eu-west-1"
dynamodb_table = "terraform-lock-csi-htr-tst-001-aws-accounts-remote-bucket"
#dynamodb_table = "terraform-lock-csi-htr-tst-002-aws-accounts"
