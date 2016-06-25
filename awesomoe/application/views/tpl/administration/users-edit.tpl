{include file="tpl/header.tpl"}
{include file="tpl/sidebar.tpl"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <section class="content-header">
        <h1>
            {awmultilang ident="USERS"} - {awmultilang ident="EDIT"}
            <small>Optional description</small>
        </h1>
        {include file="tpl/breadcrumb.tpl"}
    </section>
    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="box box-solid">
                    <div class="box-header with-border">
                        <i class="fa fa-user"></i>
                        <h3 class="box-title">{awmultilang ident="USER"} {awmultilang ident="EDIT"}</h3>
                    </div>
                    <form role="form" action="index.php" method="POST">
                        <input type="hidden" name="cl" value="users">
                        <input type="hidden" name="fnc" value="save">
                        <input type="hidden" name="awid" value="{$aEditUser.awid}">
                        <div class="box-body">
                            <div class="form-group">
                                <label for="name">{awmultilang ident="PRENAME"}</label>
                                <input type="text" placeholder="Vorname" id="name" class="form-control" name="awname" value="{$aEditUser.awname}">
                            </div>
                            <div class="form-group">
                                <label for="lastname">{awmultilang ident="LASTNAME"}</label>
                                <input type="text" placeholder="Nachname" id="lastname" class="form-control" name="awlastname" value="{$aEditUser.awlastname}">
                            </div>
                            <div class="form-group">
                                <label for="gender">{awmultilang ident="GENDER"}</label>
                                <div class="input-group">
                                    <div class="input-group-addon">
                                        <i class="fa fa-male"></i>
                                        <i class="fa fa-female"></i>
                                    </div>
                                    <select class="form-control" name="awgender">
                                        <option value="1"{if $aEditUser.awgender == '1'} selected="selected"{/if}>{awmultilang ident="MALE"}</option>
                                        <option value="2"{if $aEditUser.awgender == '2'} selected="selected"{/if}>{awmultilang ident="FEMALE"}</option>
                                        <option value="3"{if $aEditUser.awgender == '0' || empty($aEditUser.awgender)} selected="selected"{/if}>{awmultilang ident="NOTSETTED"}</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="email">{awmultilang ident="MAIL"}</label>
                                <div class="input-group">
                                    <div class="input-group-addon">
                                        <i class="fa fa-envelope"></i>
                                    </div>
                                    <input type="email" placeholder="{awmultilang ident="MAIL"}" id="email" class="form-control" name="awmail" value="{$aEditUser.awmail}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="phone">{awmultilang ident="PHONE"}</label>
                                <div class="input-group">
                                    <div class="input-group-addon">
                                        <i class="fa fa-phone"></i>
                                    </div>
                                    <input type="text" class="form-control" name="awphone" value="{$aEditUser.awphone}" id="phone" >
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="mobile">{awmultilang ident="MOBILE"}</label>
                                <div class="input-group">
                                    <div class="input-group-addon">
                                        <i class="fa fa-phone"></i>
                                    </div>
                                    <input type="text" placeholder="{awmultilang ident="MOBILE"}" id="mobile" class="form-control" name="awmobile" value="{$aEditUser.awmobile}" data-mask="" data-inputmask="&quot;mask&quot;: &quot;(999) 999-9999&quot;">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="mobile">{awmultilang ident="URL"}</label>
                                <div class="input-group">
                                    <div class="input-group-addon">
                                        <i class="fa fa-home"></i>
                                    </div>
                                    <input type="text" placeholder="{awmultilang ident="http://www."}" class="form-control" name="awurl" value="{$aEditUser.awurl}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="mobile">{awmultilang ident="POSITION"}</label>
                                <div class="input-group">
                                    <div class="input-group-addon">
                                        <i class="fa fa-star-o"></i>
                                    </div>
                                    <input type="text" placeholder="" id="mobile" class="form-control" name="awposition" value="{$aEditUser.awposition}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="country">{awmultilang ident="GROUP"}</label>
                                <select class="form-control" name="awgroup">
                                    <option value="1"{if $aEditUser.awgroup == '1'} selected="selected"{/if}>{awmultilang ident="ADMIN"}</option>
                                    <option value="2"{if $aEditUser.awgroup == '2'} selected="selected"{/if}>{awmultilang ident="USER"}</option>
                                    <option value="3"{if $aEditUser.awgroup == '3'} selected="selected"{/if}>{awmultilang ident="CLIENT"}</option>
                                </select>
                            </div>
                            <div class="row">
                                <div class="col-xs-12"><label>{awmultilang ident="ZIP"} {awmultilang ident="AND"} {awmultilang ident="CITY"}</label></div>
                                <div class="col-xs-2">
                                    <input type="text" placeholder="{awmultilang ident="ZIP"}" class="form-control" name="awzip" value="{$aEditUser.awzip}">
                                </div>
                                <div class="col-xs-10">
                                    <input type="text" placeholder="{awmultilang ident="CITY"}" class="form-control" name="awcity" value="{$aEditUser.awcity}">
                                </div>
                                <div class="col-xs-12">&nbsp;</div>
                            </div>
                            <div class="form-group">
                                <label for="mobile">{awmultilang ident="STREET"} {awmultilang ident="AND"} {awmultilang ident="BUILDINGNR"}</label>
                                <input type="text" placeholder="{awmultilang ident="STREET"}" id="mobile" class="form-control" name="awstreet" value="{$aEditUser.awstreet}">
                            </div>
                            <div class="form-group">
                                <label for="awpassword">{awmultilang ident="PASSWORD"}</label>
                                <input type="text" placeholder="{awmultilang ident="PASSWORD"}" id="password" class="form-control" name="awpassword" value="">
                            </div>
                            <div class="form-group">
                                <label for="country">{awmultilang ident="COUNTRY"}</label>
                                <select class="form-control" name="awcountry">
                                    <option value="1"{if $aEditUser.awcountry == '1'} selected="selected"{/if}>{awmultilang ident="GERMANY"}</option>
                                    <option value="2"{if $aEditUser.awcountry == '2'} selected="selected"{/if}>{awmultilang ident="AUSTRIA"}</option>
                                    <option value="3"{if $aEditUser.awcountry == '3'} selected="selected"{/if}>{awmultilang ident="SWISS"}</option>
                                    <option value="4"{if $aEditUser.awcountry == '4'} selected="selected"{/if}>{awmultilang ident="FRANCE"}</option>
                                    <option value="5"{if $aEditUser.awcountry == '5'} selected="selected"{/if}>{awmultilang ident="SPAIN"}</option>
                                    <option value="6"{if $aEditUser.awcountry == '7'} selected="selected"{/if}>{awmultilang ident="UNITEDKINGDOM"}</option>
                                    <option value="7"{if $aEditUser.awcountry == '0' || empty($aEditUser.awcountry)} selected="selected"{/if}>{awmultilang ident="NOTSETTED"}</option>
                                </select>
                            </div>
                        </div><!-- /.box-body -->

                        <div class="box-footer">
                            <button class="btn btn-primary" type="submit">{awmultilang ident="SAVE"}</button>
                            <a class="btn btn-default" href="index.php?cl=profile">{awmultilang ident="CANCEL"}</a>
                        </div>
                    </form>
                </div>
            </div>


        </div>
    </section><!-- /.content -->
</div><!-- /.content-wrapper -->
{include file="tpl/footer.tpl"}