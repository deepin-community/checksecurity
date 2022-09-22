#
#  This is the makefile for the Debian checksecurity package.
#
#  It installs the software in $(PREFIX)/usr/sbin, etc.
#


PREFIX=
CONFDIR=$(PREFIX)/etc
PLUGINDIR=$(PREFIX)/usr/share/checksecurity


install: clean
	install -d $(PREFIX)/usr/sbin
	install -d $(PREFIX)/usr/share/man/man8
	install -d $(CONFDIR)
	install -d $(CONFDIR)/checksecurity
	install -d $(PLUGINDIR)
	cp bin/checksecurity $(PREFIX)/usr/sbin
	chown root:root $(PREFIX)/usr/sbin/checksecurity
	chmod 755 $(PREFIX)/usr/sbin/checksecurity 
	cp man/checksecurity.8 $(PREFIX)/usr/share/man/man8
	cp man/check-diskfree.8 $(PREFIX)/usr/share/man/man8
	cp man/check-passwd.8 $(PREFIX)/usr/share/man/man8
	cp man/check-setuid.8 $(PREFIX)/usr/share/man/man8
	cp etc/check-setuid.conf $(CONFDIR)/checksecurity
	cp etc/check-socket.conf $(CONFDIR)/checksecurity
	chmod 744 $(CONFDIR)/checksecurity/check-setuid.conf
	chmod 744 $(CONFDIR)/checksecurity/check-socket.conf
	cp etc/check-passwd.conf $(CONFDIR)/checksecurity
	chmod 744 $(CONFDIR)/checksecurity/check-passwd.conf
	cp etc/check-diskfree.conf $(CONFDIR)/checksecurity
	chmod 744 $(CONFDIR)/checksecurity/check-diskfree.conf
	cp etc/global-checksecurity.conf $(CONFDIR)/checksecurity.conf
	cp plugins/check-* $(PLUGINDIR)
	chown root:root $(PLUGINDIR)/check-*
	chmod 755 $(PLUGINDIR)/check-*
	chmod -x $(CONFDIR)/checksecurity/*.conf

uninstall:
	rm -f $(PREFIX)/usr/sbin/checksecurity
	rm -f $(PREFIX)/usr/share/man/man8/checksecurity.conf.8
	rm -f $(CONFDIR)/checksecurity.conf
	rm -rf $(CONFDIR)/checksecurity
	rm -rf $(PLUGINDIR)

clean:
	-find . -name '*~' -print | xargs rm -f
	-rm -f build-stamp
	-rm -f debian/files
