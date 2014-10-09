package com.game.protect.model
{
    import com.cfg.obj.*;

    public class ProtectConst extends Object
    {
        public static var passwordPattern:RegExp = /^[a-zA-Z0-9]{6,15}$/;
        public static var emailPattern:RegExp = /^[a-zA-Z0-9_\.-]+@[a-zA-Z0-9\.-]+\.[a-zA-Z\.]{2,6}$/;
        public static var phonePattern:RegExp = /^(\+[0-9]{2,6})?1[3458][0-9]{9}$/;
        public static var passwordRestrict:String = "a-zA-Z0-9";

        public function ProtectConst()
        {
            return;
        }// end function

        public static function get protectEnablePlayerLevel() : int
        {
            return GlobalCfgObj.getInstance().getProtectEnablePlayerLevel();
        }// end function

    }
}
