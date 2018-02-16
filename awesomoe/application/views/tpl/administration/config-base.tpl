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
                            <h3 class="box-title">{awmultilang ident="CONFIG"} {awmultilang ident="BASE"}</h3>
                        </div>
                        <form role="form" action="index.php" method="POST">
                            <input type="hidden" name="cl" value="config">
                            <input type="hidden" name="fnc" value="save">
                            <div class="box-body">
                                <div class="form-group">
                                    <label for="name">{awmultilang ident="AWESOMOENAME"}</label>
                                    <input type="text" placeholder="{awmultilang ident="AWESOMOE"}" id="name" class="form-control" name="sTitle" value="{$sTitle}">
                                </div>
                                <div class="form-group">
                                    <label for="sCopyright">{awmultilang ident="COPYRIGHT"}</label>
                                    <input type="text" placeholder="{awmultilang ident="AWESOMOE"}" id="name" class="form-control" name="sCopyright" value="{$sCopyright}">
                                </div>
                                <div class="form-group">
                                    <label for="sCopyrightLink">{awmultilang ident="COPYRIGHTLINK"}</label>
                                    <input type="text" placeholder="{awmultilang ident="AWESOMOE"}" id="name" class="form-control" name="sCopyrightLink" value="{$sCopyrightLink}">
                                </div>
                                <div class="form-group">
                                    <label for="sFooterInfo">{awmultilang ident="FOOTERINFOTEXT"}</label>
                                    <input type="text" placeholder="{awmultilang ident="AWESOMOE"}" id="name" class="form-control" name="sFooterInfo" value="{$sFooterInfo}">
                                </div>
                                <div class="form-group">
                                    <label for="sSkin">{awmultilang ident="SKIN"}</label>
                                    <div class="input-group">
                                        <select class="form-control" name="sSkin">
                                            <option value="skin-blue"{if $sSkin == 'skin-blue'} selected="selected"{/if}>{awmultilang ident="SKINBLUE"}</option>
                                            <option value="skin-black"{if $sSkin == 'skin-black'} selected="selected"{/if}>{awmultilang ident="SKINBLACK"}</option>
                                            <option value="skin-green"{if $sSkin == 'skin-green'} selected="selected"{/if}>{awmultilang ident="SKINGREEN"}</option>
                                            <option value="skin-purple"{if $sSkin == 'skin-purple'} selected="selected"{/if}>{awmultilang ident="SKINPURPLE"}</option>
                                            <option value="skin-red"{if $sSkin == 'skin-red'} selected="selected"{/if}>{awmultilang ident="SKINRED"}</option>
                                            <option value="skin-yellow"{if $sSkin == 'skin-yellow'} selected="selected"{/if}>{awmultilang ident="SKINYELLOW"}</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="iDays4NewTasks">{awmultilang ident="DAYS4NEWTASKS"}</label>
                                    <input type="text" placeholder="2" id="name" class="form-control" name="iDays4NewTasks" value="{$iDays4NewTasks}">
                                </div>
                                <div class="form-group">
                                    <label for="iDays4EndTime">{awmultilang ident="DAYS4ENDTASKS"}</label>
                                    <input type="text" placeholder="2" id="name" class="form-control" name="iDays4EndTime" value="{$iDays4EndTime}">
                                </div>

                                <div class="form-group">
                                    <label for="agileView">{awmultilang ident="AGILETABLEDIVVIEW"}</label>
                                    <div class="input-group">
                                        <select class="form-control" name="iAgileType">
                                            <option value="1"{if $iAgileType == '1'} selected="selected"{/if}>{awmultilang ident="AGILETABLE"}</option>
                                            <option value="2"{if $iAgileType == '2'} selected="selected"{/if}>{awmultilang ident="AGILEDIV"}</option>
                                        </select>
                                    </div>
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