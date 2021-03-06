ActionController::Routing::Routes.draw do |map|

  map.resources :position_info_items,:only => [:update,:create,:show]

  map.resources :position_infos,:has_many => :position_info_items

  map.resources :org_infos #,:has_many => :position_infos

  map.resources :content_items,:collection => {:first => :get}

  #所有票据出库单
  map.resources :all_invoice_shippments,:only => :index
  #所有入库单
  map.resources :all_invoice_receipts,:only => :index
  #职位
  map.resources :positions

  map.resources :invoice_checks

  map.resources :computer_invoice_shippments,:member => {:confirm => :put}

  map.resources :computer_invoice_receipts,:member => {:confirm => :put}

  map.resources :computer_invoices

  map.resources :hand_invoice_shippments,:member => {:show_confirm => :get,:confirm => :put}

  map.resources :hand_invoices

  map.resources :hand_invoice_receipts,:member => {:confirm => :put}

  map.resources :common_invoice_shippments,:member => {:confirm => :put}

  map.resources :common_invoice_receipts,:member => {:confirm => :put}

  map.resources :common_invoices

  map.resources :budget_tables

  map.resources :org_management_fee_configs

  map.resources :management_fee_configs

  map.resources :chat_messages,:only => [:index,:create,:destroy]

  map.resources :salary_tables,:member => {:audit => :put },:collection => {:index_sum => :get}

  map.resources :employees

  map.resources :suggestions,:has_many => :comments

  map.resources :votes

  map.resources :punishments,:member => {:export_excel => :get}

  map.resources :violations

  map.resources :settlement_lines,:only => [:index]

  map.resources :scrapped_infos

  map.resources :clear_infos,:has_many => [:bills],:except => [:update,:destroy]

  map.resources :delivers,:has_many => [:bills],:except => [:update,:destroy]

  map.resources :post_infos,:member => {:audit => :put},:has_many => [:bills],:except => [:update,:destroy]

  map.resources :config_infos

  map.resources :tk_infos,:has_many => [:bills],:except => [:update,:destroy]

  map.resources :confirms,:member => {:audit => :put},:has_many => [:bills],:except => [:update,:destroy]

  map.resources :inout_bills,:member => {:select => :get }

  map.resources :carrying_bills,:member => {:select => :get }

  map.resources :bills,:collection => {:search => :get}

  map.resources :clients,:except => [:index]

  map.devise_for :users

  map.resources :users,:except => [:create,:update],:collection => {:show_org_users => :get,:create_ex => :post},:member => {:update_ex => :put}

  map.resources :vip_configs

  map.resources :vip_infos,:only => [:index],:collection => {:remove => :delete}

  map.resources :vip_fee_infos,:only => [:index]

  map.resources :upload_vip_files,:only => [:new],:collection => {:import => :post}

  map.resources :consumer_shippments,:member => {:confirm => :put}

  map.resources :durable_shippments,:member => {:confirm => :put}

  map.resources :consumer_receipts,:member => {:confirm => :put}

  map.resources :durable_receipts,:member => {:confirm => :put}

  map.resources :consumer_materials

  map.resources :durable_materials

  map.resources :m_storages,:collection => {:index_invoice => :get,:show_search => :get,:search => :get}

  map.resources :material_inout_lines,:only => [:index]

  map.resources :warehouses

  map.resources :settlements,:member => {:audit => :put,:sign => :put},:collection => {:batch_sign => :put}

  map.resources :address_books

  map.resources :address_book_lines

  map.resources :comments,:except => [:index,:destroy,:new]

  map.resources :posts,:member => {:publish => :put},:has_many => :comments

  map.resources :rules,:member => {:publish => :put},:collection => {:show_overdue_search => :get,:overdue_search => :get}

  map.resources :notices,:member => {:publish => :put},:collection => {:show_overdue_search => :get,:overdue_search => :get}

  map.resources :sub_companies

  map.resources :departments

  map.resources :contracts,:member => {:disable_alert => :put}

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => :home

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
