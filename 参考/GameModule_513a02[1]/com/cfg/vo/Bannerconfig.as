package com.cfg.vo
{

    public class Bannerconfig extends Object
    {
        public var guildbannerlv:int;
        public var monsterlist:int;
        public var shuxing:String;
        public var changname:String;
        public var changicon:String;
        public var levelup:String;
        public var successcof:int;
        public var buffid:int;
        public var expcof:int;
        public var dazuocof:int;
        public var q_attribute:String;

        public function Bannerconfig()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            this.guildbannerlv = param1.guildbannerlv;
            this.monsterlist = param1.monsterlist;
            this.shuxing = param1.shuxing;
            this.changname = param1.changname;
            this.changicon = param1.changicon;
            this.levelup = param1.levelup;
            this.successcof = param1.successcof;
            this.buffid = param1.buffid;
            this.expcof = param1.expcof;
            this.dazuocof = param1.dazuocof;
            this.q_attribute = param1.q_attribute;
            return;
        }// end function

    }
}
