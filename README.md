## sql

```sql
create table new_member_table
(
    id              bigint primary key auto_increment,
    memberEmail     varchar(100) not null,
    memberPassword  varchar(20)  not null,
    memberName      varchar(20)  not null,
    memberMobile    varchar(20),
    profileAttached int default 0
);

create table member_profile_table
(
    id               bigint primary key auto_increment,
    originalFileName varchar(100),
    storedFileName   varchar(100),
    memberId         bigint,
    constraint foreign key (memberId) references new_member_table (id) on delete cascade
);
```