CanvasRails::Application.routes.draw do
  scope :format => 'json', :constraints => { :format => 'json' } do
    # non-versioned api urls
    match "sfu/api/course/:sis_id(/:property)" => "api#course", :defaults => { :property => nil }, via: :get
    match "sfu/api/user/:sfu_id(/:property)"  => "api#user", :defaults => { :property => nil }, via: :get
    match "sfu/api/courses/teaching/:sfuid(/:term)"  => "api#courses", :defaults => { :term => nil }, via: :get
    match "sfu/api/course-data/:term(/:query)"  => "course_data#search", :defaults => { :term => nil, :query => nil }, via: :get
    match "sfu/api/amaint/course/:sis_id(/:property)"  => "amaint#course_info", :defaults => { :property => nil }, via: :get

    # v1 api urls
    match "sfu/api/v1/terms" => "term#all_terms", via: :get
    match "sfu/api/v1/terms/current" => "term#current_term", via: :get
    match "sfu/api/v1/terms/next(/:num_terms)" => "term#next_terms", :defaults => { :num_terms => 1 }, via: :get
    match "sfu/api/v1/terms/previous(/:num_terms)" => "term#prev_terms", :defaults => { :num_terms => 1 }, via: :get
    match "sfu/api/v1/terms/:sis_id" => "term#term_by_sis_id", via: :get
    match "sfu/api/v1/course/:sis_id(/:property)" => "api#course", :defaults => { :property => nil }, via: :get
    match "sfu/api/v1/user/:sfu_id(/:property)" => "api#user", :defaults => { :property => nil }, via: :get
    match "sfu/api/v1/course-data/:term(/:query)" => "course_data#search", :defaults => { :query => nil }, via: :get
    match "sfu/api/v1/amaint/user/:sfu_id(/:property(/:filter))" => "amaint#user_info", :defaults => { :property => nil, :filter => nil }, via: :get
    match "sfu/api/v1/amaint/course/:sis_id(/:property)" => "amaint#course_info", :defaults => { :property => nil }, via: :get
    match "sfu/api/v1/enrollment" => "api#course_enrollment", via: :post
    match "sfu/api/v1/group_memberships/:id/undelete" => "api#undelete_group_membership", via: :put
  end
end
