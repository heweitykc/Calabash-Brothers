package com.f1.utils.cue
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.ui.container.*;

    public class ServerHitCue extends BaseSprite
    {
        private var vecServer:Vector.<ServerHitIcon>;
        private var serverList:HBox;

        public function ServerHitCue()
        {
            this.vecServer = new Vector.<ServerHitIcon>;
            this.initCue();
            return;
        }// end function

        override public function set x(param1:Number) : void
        {
            super.x = param1;
            return;
        }// end function

        private function initCue() : void
        {
            this.serverList = new HBox();
            this.serverList.horizontal = true;
            this.addChild(this.serverList);
            return;
        }// end function

        public function addServerToList(param1:ServerHitIcon) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = this.vecServer.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_2 = this.vecServer[_loc_4];
                if (param1.type == _loc_2.type)
                {
                    _loc_2.count = param1.count + _loc_2.count;
                    return;
                }
                _loc_4++;
            }
            this.vecServer.push(param1);
            this.update();
            return;
        }// end function

        public function addServerToListCount(param1:ServerHitIcon, param2:int) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = this.vecServer.length;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_3 = this.vecServer[_loc_5];
                if (param1.type == _loc_3.type)
                {
                    _loc_3.count = param2;
                    return;
                }
                _loc_5++;
            }
            this.vecServer.push(param1);
            this.update();
            return;
        }// end function

        public function getServerIcon(param1:String) : ServerHitIcon
        {
            var _loc_3:* = null;
            var _loc_2:* = this.vecServer.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_3 = this.vecServer[_loc_4];
                if (param1 == _loc_3.type)
                {
                    return _loc_3;
                }
                _loc_4++;
            }
            return null;
        }// end function

        public function removeServerFromList(param1:ServerHitIcon) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = -1;
            var _loc_3:* = this.vecServer.length;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_4 = this.vecServer[_loc_5];
                if (param1.type == _loc_4.type)
                {
                    _loc_2 = _loc_5;
                    break;
                }
                _loc_5++;
            }
            if (_loc_2 != -1)
            {
                this.vecServer.splice(_loc_2, 1);
                this.update();
            }
            return;
        }// end function

        public function cleanAllServer() : void
        {
            while (this.vecServer.length > 0)
            {
                
                this.vecServer.pop();
            }
            this.serverList.reset();
            return;
        }// end function

        private function update() : void
        {
            var _loc_3:* = null;
            this.serverList.reset(false);
            var _loc_1:* = this.vecServer.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = this.vecServer[_loc_2];
                this.serverList.add(_loc_3);
                _loc_2++;
            }
            return;
        }// end function

    }
}
