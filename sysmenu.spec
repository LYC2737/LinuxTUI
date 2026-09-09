Name:           sysmenu
Version:        1.0
Release:        1%{?dist}
Summary:        system management menu script

License:        GPLv2+
URL:            https://example.com/sysmenu
Source0:        sysmenu-1.0.tar.gz
BuildArch:      noarch
Requires:       newt iproute systemd procps-ng

%description
A TUI-based system management script that provides menu-driven access 
to system info, error logs, and service status checks.

%prep
%setup -q

%build


%install
rm -rf $RPM_BUILD_ROOT
mkdir -p %{buildroot}%{_bindir}
install -m 0755 sysmenu.sh %{buildroot}%{_bindir}/sysmenu

%files
%{_bindir}/sysmenu


%changelog
* Wed Sep 09 2026 testUser <test@example.com>
- Initial build
