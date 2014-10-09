package com.game.artifact.cfg
{
    import com.game.artifact.util.*;
    import flash.utils.*;

    public class ArtifactRemoldCfg extends Object
    {
        public var q_id:int;
        public var q_level:int;
        public var q_count:int;
        public var q_attribute:Dictionary;

        public function ArtifactRemoldCfg(param1:Object)
        {
            this.q_id = param1.q_id;
            this.q_level = param1.q_level;
            this.q_count = param1.q_count;
            this.q_attribute = ArtifactCfgUtil.parseAttributeDict(param1.q_attribute);
            return;
        }// end function

    }
}
