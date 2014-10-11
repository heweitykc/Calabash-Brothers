package com.game.artifact.model
{

    public class ArtifactExtractSettingField extends Object
    {
        public var id:uint;
        public var name:String;
        public var type:ArtifactExtractSettingFieldType;

        public function ArtifactExtractSettingField(param1:uint, param2:String, param3:ArtifactExtractSettingFieldType)
        {
            this.id = param1;
            this.name = param2;
            this.type = param3;
            return;
        }// end function

        public function setValue(param1:Object, param2:String) : void
        {
            if (param1.hasOwnProperty(this.name))
            {
                param1[this.name] = this.type.valueFromString(param2);
            }
            return;
        }// end function

        public function getValue(param1:Object) : String
        {
            return this.type.valueToString(param1[this.name]);
        }// end function

    }
}
