package com.f1.manager
{
    import com.f1.manager.resource.*;
    import flash.utils.*;

    public class CfgManager extends Object
    {
        private var _cfgs:Dictionary;
        private var _maps:Dictionary;
        private var rawDatas:Array;
        private static var instance:CfgManager;
        public static const CFG_PATH:String = "res/config/";

        public function CfgManager()
        {
            this.rawDatas = new Array();
            this._cfgs = new Dictionary();
            this._maps = new Dictionary();
            return;
        }// end function

        public function getMap(param1:String) : Object
        {
            return this._maps[param1];
        }// end function

        public function loadCfg(param1:Function, param2:Function) : void
        {
            VResManager.load(CFG_PATH + "lang.bin", this.loadLangComplete, [param1, param2], null, param2);
            return;
        }// end function

        private function loadLangComplete(param1:ByteArray, param2:Function, param3:Function) : void
        {
            param1.uncompress();
            var _loc_4:* = param1.readByte();
            var _loc_5:* = param1.readUnsignedInt();
            this.readCfg(param1);
            VResManager.load(CFG_PATH + "cfg0.bin", this.loadFirstComplete, [param2, param3], null, param3);
            return;
        }// end function

        private function loadFirstComplete(param1:ByteArray, param2:Function, param3:Function) : void
        {
            var _loc_7:* = null;
            param1.uncompress();
            var _loc_4:* = param1.readByte();
            var _loc_5:* = param1.readUnsignedInt();
            this.rawDatas.push(param1);
            var _loc_6:* = [];
            var _loc_8:* = 1;
            while (_loc_8 < _loc_4)
            {
                
                _loc_7 = CFG_PATH + "cfg" + _loc_8 + ".bin";
                _loc_6.push(_loc_7);
                _loc_8++;
            }
            if (_loc_6.length == 0)
            {
                if (param2 != null)
                {
                    param2.apply(null);
                }
            }
            else
            {
                VResManager.loadGroup(_loc_6, this.loadOneComplete, null, null, param3, param2);
            }
            return;
        }// end function

        private function loadOneComplete(param1:ByteArray) : void
        {
            this.rawDatas.push(param1);
            return;
        }// end function

        public function parseCfgs() : void
        {
            var _loc_2:* = null;
            this.readCfg(this.rawDatas[0]);
            var _loc_1:* = 1;
            while (_loc_1 < this.rawDatas.length)
            {
                
                _loc_2 = this.rawDatas[_loc_1];
                _loc_2.uncompress();
                this.readCfg(_loc_2);
                _loc_1 = _loc_1 + 1;
            }
            this.rawDatas = null;
            return;
        }// end function

        public function readCfg(param1:ByteArray) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            while (param1.bytesAvailable > 0)
            {
                
                _loc_2 = param1.readUTF();
                _loc_3 = param1.readObject();
                this._maps[_loc_2] = _loc_3;
            }
            return;
        }// end function

        private function getCfgObjByClass(param1:String, param2:Class)
        {
            if (this._cfgs[param1] != null)
            {
                return this._cfgs[param1];
            }
            this._cfgs[param1] = new param2(this._maps[param1]);
            return this._cfgs[param1];
        }// end function

        public static function getInstance() : CfgManager
        {
            if (instance == null)
            {
                instance = new CfgManager;
            }
            return instance;
        }// end function

    }
}
