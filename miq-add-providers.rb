#!/usr/bin/env ruby

# Load Rails
ENV['RAILS_ENV'] = ARGV[0] || 'development'
require "/home/mtayer/dev/manageiq/config/environment"

ManageIQ::Providers::Hawkular::DatawarehouseManager.destroy_all
ManageIQ::Providers::Openshift::ContainerManager.destroy_all

provider_class = ManageIQ::Providers::Hawkular::DatawarehouseManager

prov = provider_class.new(
    :name                      => "dwh",
    :zone                      => Zone.last,
    :connection_configurations => [{:endpoint       => {:role       => :default,
                                                        :hostname   => ENV['HAWKULAR_HOST'],
                                                        :port       => 443,
                                                        :verify_ssl => false},
                                    :authentication => {:role     => :default,
                                                        :auth_key => ENV['HAWKULAR_TOKEN']}}]
)
prov.save
prov.authentication_check_types(:default)

provider_class = ManageIQ::Providers::Openshift::ContainerManager
prov = provider_class.new(
  :name                      => "containers",
  :zone                      => Zone.last,
  :connection_configurations => [{:endpoint       => {:role       => :default,
                                                        :hostname   => ENV['OSH_HOST'],
                                                        :port       => 8443,
                                                        :verify_ssl => false},
                                    :authentication => {:role     => :bearer,
                                                        :auth_key => ENV['OSH_TOKEN']}},
                                   {:endpoint       => {:role       => :hawkular,
                                                        :hostname   => ENV['HAWKULAR_HOST'],
                                                        :port       => 443,
                                                        :verify_ssl => false},
                                    :authentication => {:role     => :hawkular,
                                                        :auth_key => ENV['HAWKULAR_TOKEN']}}])
prov.save
prov.authentication_check_types(:bearer, :hawkular)
EmsRefresh.refresh(prov)

