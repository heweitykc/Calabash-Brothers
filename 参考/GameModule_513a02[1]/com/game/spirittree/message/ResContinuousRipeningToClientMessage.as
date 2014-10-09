package com.game.spirittree.message
{
    import __AS3__.vec.*;
    import com.game.spirittree.bean.*;
    import net.*;

    public class ResContinuousRipeningToClientMessage extends Message
    {
        private var _rewardbriefinfo:Vector.<Rewardbriefinfo>;

        public function ResContinuousRipeningToClientMessage()
        {
            this._rewardbriefinfo = new Vector.<Rewardbriefinfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._rewardbriefinfo.length);
            _loc_1 = 0;
            while (_loc_1 < this._rewardbriefinfo.length)
            {
                
                writeBean(this._rewardbriefinfo[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._rewardbriefinfo[_loc_1] = readBean(Rewardbriefinfo) as Rewardbriefinfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 133110;
        }// end function

        public function get rewardbriefinfo() : Vector.<Rewardbriefinfo>
        {
            return this._rewardbriefinfo;
        }// end function

        public function set rewardbriefinfo(param1:Vector.<Rewardbriefinfo>) : void
        {
            this._rewardbriefinfo = param1;
            return;
        }// end function

    }
}
