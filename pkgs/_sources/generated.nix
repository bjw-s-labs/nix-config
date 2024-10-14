# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  kubecolor-catppuccin = {
    pname = "kubecolor-catppuccin";
    version = "1d4c2888f7de077e1a837a914a1824873d16762d";
    src = fetchFromGitHub {
      owner = "vkhitrin";
      repo = "kubecolor-catppuccin";
      rev = "1d4c2888f7de077e1a837a914a1824873d16762d";
      fetchSubmodules = false;
      sha256 = "sha256-gTneUh6yMcH6dVKrH00G61a+apasu9tiMyYjvNdOiOw=";
    };
    date = "2024-05-24";
  };
  kubectl-browse-pvc = {
    pname = "kubectl-browse-pvc";
    version = "v1.0.7";
    src = fetchFromGitHub {
      owner = "clbx";
      repo = "kubectl-browse-pvc";
      rev = "v1.0.7";
      fetchSubmodules = false;
      sha256 = "sha256-Ql+mMgpmcbGy5TwQrv8f9uWK9yNXfHykNDnOrp4E7+I=";
    };
  };
  kubectl-get-all = {
    pname = "kubectl-get-all";
    version = "v1.3.8";
    src = fetchFromGitHub {
      owner = "corneliusweig";
      repo = "ketall";
      rev = "v1.3.8";
      fetchSubmodules = false;
      sha256 = "sha256-Mau57mXS78fHyeU0OOz3Tms0WNu7HixfAZZL3dmcj3w=";
    };
  };
  kubectl-klock = {
    pname = "kubectl-klock";
    version = "v0.7.0";
    src = fetchFromGitHub {
      owner = "applejag";
      repo = "kubectl-klock";
      rev = "v0.7.0";
      fetchSubmodules = false;
      sha256 = "sha256-MmsHxB15gCz2W2QLC6E7Ao+9iLyVaYJatUgPcMuL79M=";
    };
  };
  kubectl-netshoot = {
    pname = "kubectl-netshoot";
    version = "v0.1.0";
    src = fetchFromGitHub {
      owner = "nilic";
      repo = "kubectl-netshoot";
      rev = "v0.1.0";
      fetchSubmodules = false;
      sha256 = "sha256-6IQmD2tJ1qdjeJqOnHGSpfNg6rxDRmdW9a9Eon/EdsM=";
    };
  };
  kubectl-pgo = {
    pname = "kubectl-pgo";
    version = "v0.4.2";
    src = fetchFromGitHub {
      owner = "CrunchyData";
      repo = "postgres-operator-client";
      rev = "v0.4.2";
      fetchSubmodules = false;
      sha256 = "sha256-m1USG4Po+H9trrx4+Zw8SDCpXecEipawdwCYBLsuxd8=";
    };
  };
  shcopy = {
    pname = "shcopy";
    version = "v0.1.5";
    src = fetchFromGitHub {
      owner = "aymanbagabas";
      repo = "shcopy";
      rev = "v0.1.5";
      fetchSubmodules = false;
      sha256 = "sha256-MKlW8HrkXCYCOeO38F0S4c8mVbsG/VcZ+oGFC70amqQ=";
    };
  };
  talosctl = {
    pname = "talosctl";
    version = "v1.8.1";
    src = fetchFromGitHub {
      owner = "siderolabs";
      repo = "talos";
      rev = "v1.8.1";
      fetchSubmodules = false;
      sha256 = "sha256-6WHeiVH/vZHiM4bqq3T5lC0ARldJyZtIErPeDgrZgxc=";
    };
  };
  usage-cli = {
    pname = "usage-cli";
    version = "v0.10.0";
    src = fetchFromGitHub {
      owner = "jdx";
      repo = "usage";
      rev = "v0.10.0";
      fetchSubmodules = false;
      sha256 = "sha256-NkVBdqHtVHhyX8wkn3yJ01bKG9s82sA/deLspNECnHk=";
    };
  };
}
