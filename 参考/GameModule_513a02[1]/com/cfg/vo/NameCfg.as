package com.cfg.vo
{

    public class NameCfg extends Object
    {
        public var ID:int;
        public var FirstName:String;
        public var SecondNameMale:String;
        public var SecondNameFemale:String;

        public function NameCfg()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            this.ID = param1.ID;
            this.FirstName = param1.FirstName;
            this.SecondNameMale = param1.SecondNameMale;
            this.SecondNameFemale = param1.SecondNameFemale;
            return;
        }// end function

    }
}
