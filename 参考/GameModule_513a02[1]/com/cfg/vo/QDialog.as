package com.cfg.vo
{
    import com.model.*;

    public class QDialog extends Object
    {
        public var team:int;
        public var index:int;
        public var url:String;
        public var name:String;
        public var dir:String;
        public var content:String;

        public function QDialog()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            var _loc_2:* = param1.q_id.split("_");
            this.team = int(_loc_2[0]);
            this.index = int(_loc_2[1]);
            this.url = param1.q_head;
            this.name = param1.q_name;
            this.dir = param1.q_dir;
            this.content = param1.q_content;
            if (param1.q_name == "0")
            {
                this.name = UserObj.getInstance().playerInfo.name;
                this.url = "job" + UserObj.getInstance().playerInfo.job;
            }
            return;
        }// end function

    }
}
