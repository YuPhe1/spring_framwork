## sql

```sql
create table new_member_table
(
    id              bigint primary key auto_increment,
    memberEmail     varchar(100) not null unique,
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
create table new_board_table
(
    id            bigint primary key auto_increment,
    boardTitle    varchar(100) not null,
    boardWriterId bigint       not null,
    boardWriter   varchar(20)  not null,
    boardContents varchar(500) not null,
    boardHits     int       default 0,
    createdAt     timestamp default now(),
    fileAttached  int       default 0,
    constraint foreign key (boardWriterId) references new_member_table (id) on delete cascade
);

create table new_board_file_table
(
    id               bigint primary key auto_increment,
    originalFileName varchar(100),
    storedFileName   varchar(100),
    boardId          bigint,
    constraint foreign key (boardId) references new_board_table (id) on delete cascade
);

create table new_comment_table
(
    id              bigint primary key auto_increment,
    commentWriterId bigint       not null,
    commentWriter   varchar(20)  not null,
    createdAt       timestamp default now(),
    commentContents varchar(500) not null,
    boardId         bigint       not null,
    constraint foreign key (commentWriterId) references new_member_table (id) on delete cascade,
    constraint foreign key (boardId) references new_board_table (id) on delete cascade
);

create table comment_like_table
(
    id             bigint primary key auto_increment,
    commentLike    int default 0,
    commentDisLike int default 0,
    commentId      bigint not null,
    likeId         bigint not null,
    constraint foreign key (commentId) references new_comment_table (id) on delete cascade,
    constraint foreign key (likeId) references new_member_table (id) on delete cascade
);
```