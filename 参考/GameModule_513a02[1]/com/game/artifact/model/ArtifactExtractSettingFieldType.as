package com.game.artifact.model
{

    public class ArtifactExtractSettingFieldType extends Object
    {
        private var valueToStringImpl:Function;
        private var valueFromStringImpl:Function;
        public static var BOOLEAN:ArtifactExtractSettingFieldType = new ArtifactExtractSettingFieldType(@%@function ()@%@25181@%@, @%@function ()@%@25182@%@);
        public static var UINT:ArtifactExtractSettingFieldType = new ArtifactExtractSettingFieldType(@%@function ()@%@25183@%@, @%@function ()@%@25184@%@);

        public function ArtifactExtractSettingFieldType(param1:Function, param2:Function)
        {
            this.valueToStringImpl = param1;
            this.valueFromStringImpl = param2;
            return;
        }// end function

        public function valueToString(param1) : String
        {
            return this.valueToStringImpl(param1);
        }// end function

        public function valueFromString(param1:String)
        {
            return this.valueFromStringImpl(param1);
        }// end function

    }
}
