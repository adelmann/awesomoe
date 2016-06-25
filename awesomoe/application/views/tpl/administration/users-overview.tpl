{include file="tpl/header.tpl"}
{include file="tpl/sidebar.tpl"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <section class="content-header">
        <h1>
            {awmultilang ident="USERS"}
        </h1>
        {include file="tpl/breadcrumb.tpl"}
    </section>

    <!-- Main content -->
    <section class="content">
        {if $aActUser.awgroup == '1'}
            <a class="btn btn-app" href="index.php?cl=users&fnc=add">
                <i class="fa fa-plus"></i> {awmultilang ident="NEWUSER"}
            </a>
        {/if}
        <div class="row">
            <div class="col-xs-12">
                <div class="box">
                    <div class="box-header">
                        <h3 class="box-title">{awmultilang ident="USERLIST"}</h3>

                    </div><!-- /.box-header -->
                    <div class="box-body table-responsive no-padding">
                        <table class="table table-hover">
                            <tr>
                                <th>{awmultilang ident="ID"}</th>
                                <th>{awmultilang ident="NAME"}</th>
                                <th>{awmultilang ident="MAIL"}</th>
                                <th>{awmultilang ident="COMPANY"}</th>
                                <th>{awmultilang ident="POSITION"}</th>
                                <th>{awmultilang ident="PROJECTS"}</th>
                                <th></th>
                            </tr>
                            {foreach from=$oUsers item=user}
                                <tr>
                                    <td>{$user.awid}</td>
                                    <td>{$user.awname} {$user.awlastname}</td>
                                    <td>{$user.awmail}</td>
                                    <td>{$user.awcompany}</td>
                                    <td>{$user.awposition}</td>
                                    <td>{$user.projects}</td>
                                    <td>
                                        <div class="btn-group">
                                            <a class="btn btn-default" href="index.php?cl=users&fnc=edit&user={$user.awid}">
                                                <i class="fa fa-edit"></i>
                                            </a>
                                            <a class="btn btn-default" href="index.php?cl=users&fnc=delete&user={$user.awid}" class="fnc" id="delete-{$user.awid}">
                                                <i class="fa fa-minus"></i>
                                            </a>
                                            <a class="btn btn-default" href="index.php?cl=users&fnc=resetpwd&user={$user.awid}" class="fnc" id="resetpwd-{$user.awid}">
                                                <i class="fa fa-reply"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            {/foreach}

                        </table>
                    </div><!-- /.box-body -->
                </div><!-- /.box -->
            </div>
        </div>
    </section>
</div>
{include file="tpl/footer.tpl"}