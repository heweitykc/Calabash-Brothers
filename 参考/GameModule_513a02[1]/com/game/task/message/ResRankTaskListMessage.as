package com.game.task.message
{
    import __AS3__.vec.*;
    import com.game.task.bean.*;
    import net.*;

    public class ResRankTaskListMessage extends Message
    {
        private var _tasklist:Vector.<RankTaskInfo>;
        private var _completetasklist:Vector.<int>;

        public function ResRankTaskListMessage()
        {
            this._tasklist = new Vector.<RankTaskInfo>;
            this._completetasklist = new Vector.<int>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._tasklist.length);
            _loc_1 = 0;
            while (_loc_1 < this._tasklist.length)
            {
                
                writeBean(this._tasklist[_loc_1]);
                _loc_1++;
            }
            writeShort(this._completetasklist.length);
            _loc_1 = 0;
            while (_loc_1 < this._completetasklist.length)
            {
                
                writeInt(this._completetasklist[_loc_1]);
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
                
                this._tasklist[_loc_1] = readBean(RankTaskInfo) as RankTaskInfo;
                _loc_1++;
            }
            var _loc_3:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_3)
            {
                
                this._completetasklist[_loc_1] = readInt();
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 120114;
        }// end function

        public function get tasklist() : Vector.<RankTaskInfo>
        {
            return this._tasklist;
        }// end function

        public function set tasklist(param1:Vector.<RankTaskInfo>) : void
        {
            this._tasklist = param1;
            return;
        }// end function

        public function get completetasklist() : Vector.<int>
        {
            return this._completetasklist;
        }// end function

        public function set completetasklist(param1:Vector.<int>) : void
        {
            this._completetasklist = param1;
            return;
        }// end function

    }
}
