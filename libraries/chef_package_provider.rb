class Chef
  class Provider
    class ChefPackage < Chef::Provider::LWRPBase
      include QaChefServerCluster::ChefPackageHelper
      provides :chef_package

      use_inline_resources

      def whyrun_supported?
        true
      end

      # def initialize(name, run_context = nil)
      #   super(name, run_context)
      #   # extend ::QaChefServerCluster::
      #   end
      # end

      action :install do
        install_product(new_resource)
      end

      action :upgrade do
        if %w( chef-server private-chef ).include?(new_resource.product_name)
          run_chef_server_upgrade_procedure(new_resource)
        else
          install_product(new_resource)
        end
      end

      action :reconfigure do
        reconfigure_product(new_resource)
      end
    end
  end
end
