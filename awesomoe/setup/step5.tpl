<h3><?php $this->translateContent('ADDUSERINITIAL'); ?></h3>
<form action="index.php" name="dbconn" method="GET">
    <div class="form-group">
        <label for="userfname"><?php $this->translateContent('FNAME'); ?></label>
        <input type="text" name="userfname" class="form-control" id="basic-url" aria-describedby="basic-addon3">
    </div>
    <div class="form-group">
        <label for="userlname"><?php $this->translateContent('LNAME'); ?></label>
        <input type="text" name="userlname" class="form-control" id="basic-url" aria-describedby="basic-addon3">
    </div>
    <div class="form-group">
        <label for="usermail"><?php $this->translateContent('MAIL'); ?></label>
        <input type="text" name="usermail" class="form-control" id="basic-url" aria-describedby="basic-addon3">
    </div>
    <div class="form-group">
        <label for="userpassword"><?php $this->translateContent('PWD'); ?></label>
        <input type="password" name="userpassword" class="form-control" id="basic-url" aria-describedby="basic-addon3">
    </div>
    <input type="hidden" name="step" value="6">
    <input type="submit" class="btn btn-primary" value="<?php $this->translateContent('SAVE'); ?>"/>
</form>