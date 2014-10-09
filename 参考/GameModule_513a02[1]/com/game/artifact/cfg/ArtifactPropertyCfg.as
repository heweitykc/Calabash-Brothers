package com.game.artifact.cfg
{
    import com.game.artifact.util.*;
    import flash.utils.*;

    public class ArtifactPropertyCfg extends Object
    {
        public var q_level:int;
        public var q_step:int;
        public var q_client_level:int;
        public var q_name:String;
        public var q_resource:String;
        public var q_exp:Number;
        public var q_attribute:Dictionary;

        public function ArtifactPropertyCfg(param1:Object)
        {
            this.q_level = param1.q_level;
            this.q_step = param1.q_step;
            this.q_client_level = param1.q_client_level;
            this.q_name = param1.q_name;
            this.q_resource = param1.q_resource;
            this.q_exp = param1.q_exp;
            this.q_attribute = ArtifactCfgUtil.parseAttributeDict(param1.q_attribute);
            return;
        }// end function

        public function get photoUrl() : String
        {
            return "art/res/artifact/" + this.q_resource + ".png";
        }// end function

        public function get nameUrl() : String
        {
            return "art/res/artifact/name/" + this.q_resource + ".png";
        }// end function

    }
}
