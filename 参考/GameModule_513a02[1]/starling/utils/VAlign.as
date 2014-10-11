﻿package starling.utils
{
    import starling.errors.*;

    final public class VAlign extends Object
    {
        public static const TOP:String = "top";
        public static const CENTER:String = "center";
        public static const BOTTOM:String = "bottom";

        public function VAlign()
        {
            throw new AbstractClassError();
        }// end function

        public static function isValid(param1:String) : Boolean
        {
            return param1 == TOP || param1 == CENTER || param1 == BOTTOM;
        }// end function

    }
}
