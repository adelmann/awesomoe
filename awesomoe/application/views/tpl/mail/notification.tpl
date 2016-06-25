<h3>{awmultilang ident="HELLO"} {$oUser->getUserName($awuserid)},</h3>
<p class="lead">
    {$oUser->getUserName($awchanginguser)} {awmultilang ident="MADECHANGEON"}
    <a href="{$mainUrl}index.php?cl=tasklist&fnc=taskdetails&project={$awprojectid}&task={$awtaskid}">{$awtaskname}</a>
</p>

<p>
    {awmultilang ident="TYPEOFCHANGE"}:
    {if $awtype == '1'}
        {awmultilang ident="NEWCOMMENT"}
    {elseif  $awtype == '2'}
        {awmultilang ident="NEWWORKLOG"}
    {elseif  $awtype == '3'}
        {awmultilang ident="STATECHANGE"}
    {elseif  $awtype == '4'}
        {awmultilang ident="DESCRIPTIONCHANGE"}
    {elseif  $awtype == '5'}
        {awmultilang ident="NEWASSIGNEE"}
    {elseif  $awtype == '6'}
        {awmultilang ident="NEWTASK"}
    {/if}
</p>
