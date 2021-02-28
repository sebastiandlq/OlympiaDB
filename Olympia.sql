create table users(
	user_id bigint not null primary key unique auto_increment,
	first_name varchar(45),
    last_name varchar(45),
    phone varchar(45),
    email varchar(45),
    password varchar(45) 
);

create table user_histories(
	history_id bigint not null primary key unique auto_increment,
    action varchar(45),
    created_at datetime,
    created_by bigint,
    constraint fk_user foreign key(created_by) references users(user_id)
);

create table products(
	product_id bigint not null primary key unique auto_increment,
    name varchar(45),
    description varchar(100),
    stock int,
    price float,
    sku varchar(45),
    brand varchar(45),
    model varchar(45),
    is_active tinyint,
    rating_average smallint,
    created_at datetime,
    updated_at datetime,
    deleted_at datetime,
    created_by bigint,
    updated_by bigint,
    deleted_by bigint,
    constraint fk_created foreign key(created_by) references users(user_id),
    constraint fk_updated foreign key(updated_by) references users(user_id),
    constraint fk_deleted foreign key(deleted_by) references users(user_id)
);

create table products_comments(
	comment_id bigint not null primary key unique auto_increment,
    comment varchar(100),
    rating smallint,
    product_id bigint,
    created_at datetime,
    updated_at datetime,
    deleted_at datetime,
    created_by bigint,
    updated_by bigint,
    deleted_by bigint,
    constraint fk_producta foreign key(product_id) references products(product_id),
    constraint fk_createda foreign key(created_by) references users(user_id),
    constraint fk_updateda foreign key(updated_by) references users(user_id),
    constraint fk_deleteda foreign key(deleted_by) references users(user_id)
);

create table product_images(
	image_id bigint not null primary key unique auto_increment,
    img_url varchar(100),
    product_id bigint,
    created_at datetime,
    updated_at datetime,
    deleted_at datetime,
    hash varchar(45),
    created_by bigint,
    updated_by bigint,
    deleted_by bigint,
    constraint fk_producti foreign key(product_id) references products(product_id),
    constraint fk_createdi foreign key(created_by) references users(user_id),
    constraint fk_updatedi foreign key(updated_by) references users(user_id),
    constraint fk_deletedi foreign key(deleted_by) references users(user_id)
);

create table product_qualificator_values(
	value_id bigint not null primary key unique auto_increment,
    qualificator_id bigint,
    product_id bigint,
    value varchar(20),
    constraint fk_qualificator foreign key(qualificator_id) references product_qualifications(qualificator_id),
    constraint fk_productq foreign key(product_id) references products(product_id)
);

create table product_qualifications(
	qualificator_id bigint not null primary key unique auto_increment,
    name varchar(45),
    description varchar(100),
    type varchar(45),
    icon varchar(100)
);

create table coupons(
	coupon_id bigint not null primary key unique auto_increment,
    code varchar(45),
    type smallint,
    ammount float,
    uses_count int,
    max_uses int,
    created_at datetime,
    updated_at datetime,
    deleted_at datetime,
    created_by bigint,
    updated_by bigint,
    deleted_by bigint,
    constraint fk_createdc foreign key(created_by) references users(user_id),
    constraint fk_updatedc foreign key(updated_by) references users(user_id),
    constraint fk_deletedc foreign key(deleted_by) references users(user_id)
);

create table payment_methods(
	method_id bigint not null primary key unique auto_increment,
    name varchar(45),
    description varchar(100),
    created_at datetime,
    updated_at datetime,
    deleted_at datetime,
    created_by bigint,
    updated_by bigint,
    deleted_by bigint,
    constraint fk_createdp foreign key(created_by) references users(user_id),
    constraint fk_updatedp foreign key(updated_by) references users(user_id),
    constraint fk_deletedp foreign key(deleted_by) references users(user_id)
);

create table payment_statuses(
	status_id bigint not null primary key unique auto_increment,
    name varchar(45),
    description varchar(100),
    created_at datetime,
    updated_at datetime,
    deleted_at datetime,
    created_by bigint,
    updated_by bigint,
    deleted_by bigint,
    constraint fk_createdstat foreign key(created_by) references users(user_id),
    constraint fk_updatedstat foreign key(updated_by) references users(user_id),
    constraint fk_deletedstat foreign key(deleted_by) references users(user_id)
);

create table order_types(
	order_type_id bigint not null primary key unique auto_increment,
    name varchar(45),
    description varchar(45),
    created_at datetime,
    updated_at datetime,
    deleted_at datetime,
    created_by bigint,
    updated_by bigint,
    deleted_by bigint,
    constraint fk_createdorty foreign key(created_by) references users(user_id),
    constraint fk_updatedorty foreign key(updated_by) references users(user_id),
    constraint fk_deletedorty foreign key(deleted_by) references users(user_id)
);

create table order_adresses(
	adress_id bigint not null primary key unique auto_increment,
    external_number varchar(45),
    internal_number varchar(45),
    street varchar(45),
    neighborhood varchar(45),
    municipality varchar(45),
    zip_code varchar(45),
    state varchar(45),
    country varchar(45),
    created_at datetime,
    created_by bigint,
    constraint fk_useradr foreign key(created_by) references users(user_id)
);

create table orders(
	order_id bigint not null primary key unique auto_increment,
    total float,
    discount float,
    created_at datetime,
    updated_at datetime,
    deleted_at datetime,
    created_by bigint,
    updated_by bigint,
    deleted_by bigint,
    order_type_id bigint,
    order_adress_id bigint,
    payment_method_id bigint,
    payment_status_id bigint,
    constraint fk_createdorder foreign key(created_by) references users(user_id),
    constraint fk_updatedorder foreign key(updated_by) references users(user_id),
    constraint fk_deletedorder foreign key(deleted_by) references users(user_id),
    constraint fk_order_type foreign key(order_type_id) references order_types(order_type_id),
    constraint fk_order_adress foreign key(order_adress_id) references order_adresses(adress_id),
	constraint fk_method foreign key(payment_method_id) references payment_methods(method_id),
    constraint fk_payment_status foreign key(payment_status_id) references payment_statuses(status_id)
);

create table order_products(
	product_id bigint,
    order_id bigint,
    constraint fk_product_id foreign key(product_id) references products(product_id),
    constraint fk_order_id foreign key(order_id) references orders(order_id)
);