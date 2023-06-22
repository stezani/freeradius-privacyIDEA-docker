FROM freeradius/freeradius-server

# Install required system packages (if any)
# For example:
RUN apt-get update && apt-get install -y vim build-essential gcc make libssl-dev zlib1g-dev

# Install additional Perl modules using CPAN
RUN cpan LWP::Simple && \
    cpan Config::IniFiles && \
    cpan Data::Dump && \
    cpan Try::Tiny && \
    cpan JSON && \
    cpan Time::HiRes && \
    cpan URI::Encode && \
    cpan Net::SSLeay && \
    cpan IO::Socket::SSL && \
    cpan IO::Socket::SSL::Utils && \
    cpan LWP::Protocol::https

# Set any additional configuration if needed
# For example:
# COPY radiusd.conf /etc/raddb/

# Expose any necessary ports
# For example:
# EXPOSE 1812/udp
# EXPOSE 1813/udp

# Set the entry point command
CMD ["radiusd", "-f", "-xx"]
