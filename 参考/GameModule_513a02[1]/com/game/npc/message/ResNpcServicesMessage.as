package com.game.npc.message
{
    import __AS3__.vec.*;
    import com.game.npc.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ResNpcServicesMessage extends Message
    {
        private var _npcId:long;
        private var _services:Vector.<ServiceInfo>;

        public function ResNpcServicesMessage()
        {
            this._services = new Vector.<ServiceInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeLong(this._npcId);
            writeShort(this._services.length);
            _loc_1 = 0;
            while (_loc_1 < this._services.length)
            {
                
                writeBean(this._services[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._npcId = readLong();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._services[_loc_1] = readBean(ServiceInfo) as ServiceInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 140101;
        }// end function

        public function get npcId() : long
        {
            return this._npcId;
        }// end function

        public function set npcId(param1:long) : void
        {
            this._npcId = param1;
            return;
        }// end function

        public function get services() : Vector.<ServiceInfo>
        {
            return this._services;
        }// end function

        public function set services(param1:Vector.<ServiceInfo>) : void
        {
            this._services = param1;
            return;
        }// end function

    }
}
