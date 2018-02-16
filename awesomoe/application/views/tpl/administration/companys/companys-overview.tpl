{include file="tpl/header.tpl"}
{include file="tpl/sidebar.tpl"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <section class="content-header">
        <h1>
            {awmultilang ident="COMPANYS"}
        </h1>
        {include file="tpl/breadcrumb.tpl"}
    </section>

    <!-- Main content -->
    <section class="content">
        {if $aActUser.awgroup == '1'}
            <a class="btn btn-app" href="index.php?cl=companys&fnc=add">
                <i class="fa fa-plus"></i> {awmultilang ident="NEWCOMPANY"}
            </a>
        {/if}
        <div class="row">
            <div class="col-xs-12">
                <div class="box">
                    <div class="box-header">
                        <h3 class="box-title">{awmultilang ident="COMPANYLIST"}</h3>

                    </div><!-- /.box-header -->
                    <div class="box-body table-responsive no-padding">
                        <table class="table table-hover">
                            <tr>
                                <th>{awmultilang ident="ID"}</th>
                                <th>{awmultilang ident="NAME"}</th>
                                <th>{awmultilang ident="MAIL"}</th>
                                <th></th>
                            </tr>
                            {foreach from=$oCompanys item=company}
                                <tr>
                                    <td>{$company.awid}</td>
                                    <td>{$company.awname}</td>
                                    <td>{$company.awmail}</td>
                                    <td>
                                        <div class="btn-group">
                                            <a class="btn btn-default" href="index.php?cl=companys&fnc=edit&company={$company.awid}">
                                                <i class="fa fa-edit"></i>
                                            </a>
                                            <a class="btn btn-default" href="index.php?cl=companys&fnc=delete&company={$company.awid}" class="fnc" id="delete-{$company.awid}">
                                                <i class="fa fa-minus"></i>
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