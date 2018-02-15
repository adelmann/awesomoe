{include file="tpl/header.tpl"}
{include file="tpl/sidebar.tpl"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <section class="content-header">
        <h1>
            {awmultilang ident="CONFIG"}
        </h1>
        {include file="tpl/breadcrumb.tpl"}
    </section>
    <!-- Main content -->
    <section class="content">
        {if $aActUser.awgroup == '1'}
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <i class="fa fa-user"></i>
                            <h3 class="box-title">{awmultilang ident="CONFIG"} {awmultilang ident="MAIL"}</h3>
                        </div>
                        <form role="form" action="index.php" method="POST">
                            <input type="hidden" name="cl" value="config">
                            <input type="hidden" name="fnc" value="save">
                            <div class="box-body">
                                <div class="form-group">
                                    <label for="sCopyright">{awmultilang ident="MAILNAME"}</label>
                                    <input type="text" placeholder="{awmultilang ident="MAILNAME"}" id="name" class="form-control" name="sMailName" value="{$sMailName}">
                                </div>
                                <div class="form-group">
                                    <label for="sCopyrightLink">{awmultilang ident="MAILADRESS"}</label>
                                    <input type="text" placeholder="{awmultilang ident="MAILADRESS"}" id="name" class="form-control" name="sMailAdress" value="{$sMailAdress}">
                                </div>
                            </div><!-- /.box-body -->

                            <div class="box-footer">
                                <button class="btn btn-primary" type="submit">{awmultilang ident="SAVE"}</button>
                            </div>
                        </form>
                    </div>
                </div>


            </div>
        {/if}

    </section><!-- /.content -->
</div><!-- /.content-wrapper -->
{include file="tpl/footer.tpl"}