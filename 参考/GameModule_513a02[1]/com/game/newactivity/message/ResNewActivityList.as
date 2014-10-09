package com.game.newactivity.message
{
    import __AS3__.vec.*;
    import com.game.newactivity.bean.*;
    import net.*;

    public class ResNewActivityList extends Message
    {
        private var _activities:Vector.<SimpleActivityInfo>;

        public function ResNewActivityList()
        {
            this._activities = new Vector.<SimpleActivityInfo>;
            return;
        }// end function

        public function set activities(param1:Vector.<SimpleActivityInfo>) : void
        {
            this._activities = param1;
            return;
        }// end function

        public function get activities() : Vector.<SimpleActivityInfo>
        {
            return this._activities;
        }// end function

        override public function getId() : int
        {
            return 511000;
        }// end function

        override protected function writing() : Boolean
        {
            writeShort(this._activities.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._activities.length)
            {
                
                writeBean(this._activities[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._activities[_loc_2] = readBean(SimpleActivityInfo) as SimpleActivityInfo;
                _loc_2++;
            }
            return true;
        }// end function

    }
}
