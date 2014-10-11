package com.game.artifact.util
{

    public class ArtifactTextUtil extends Object
    {

        public function ArtifactTextUtil()
        {
            return;
        }// end function

        public static function addNormalLink(param1:String, param2:String, param3:uint) : String
        {
            return addLink(addColor(addUnderLine(param1), param3), param2);
        }// end function

        public static function addLink(param1:String, param2:String) : String
        {
            return "<a href=\'event:" + param2 + "\'>" + param1 + "</a>";
        }// end function

        public static function addColor(param1:String, param2:uint) : String
        {
            return "<font color=\'#" + param2.toString(16) + "\'>" + param1 + "</font>";
        }// end function

        public static function addUnderLine(param1:String) : String
        {
            return "<u>" + param1 + "</u>";
        }// end function

    }
}
