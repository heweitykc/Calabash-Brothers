package com.game.masterequip.bean
{
    import com.game.utils.*;
    import net.*;

    public class EheartInfo extends Bean
    {
        private var _modelId:int;
        private var _index:int;
        private var _eheartId:long;
        private var _exp:int;
        private var _lock:int;

        public function EheartInfo()
        {
            return;
        }// end function

        public function set modelId(param1:int) : void
        {
            this._modelId = param1;
            return;
        }// end function

        public function get modelId() : int
        {
            return this._modelId;
        }// end function

        public function set index(param1:int) : void
        {
            this._index = param1;
            return;
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        public function set eheartId(param1:long) : void
        {
            this._eheartId = param1;
            return;
        }// end function

        public function get eheartId() : long
        {
            return this._eheartId;
        }// end function

        public function set exp(param1:int) : void
        {
            this._exp = param1;
            return;
        }// end function

        public function get exp() : int
        {
            return this._exp;
        }// end function

        public function set lock(param1:int) : void
        {
            this._lock = param1;
            return;
        }// end function

        public function get lock() : int
        {
            return this._lock;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._index);
            writeLong(this._eheartId);
            writeInt(this._modelId);
            writeInt(this._exp);
            writeInt(this._lock);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._index = readInt();
            this._eheartId = readLong();
            this._modelId = readInt();
            this._exp = readInt();
            this._lock = readInt();
            return true;
        }// end function

    }
}
