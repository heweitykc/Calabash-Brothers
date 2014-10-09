package com.f1.view.mapeditor
{
    import com.f1.*;
    import com.f1.manager.resource.*;
    import com.f1.utils.*;
    import flash.display.*;
    import flash.net.*;
    import flash.utils.*;
    import starling.display.*;
    import starling.textures.*;

    public class BgGPUView extends BaseGPUSprite
    {
        private var _buildsList:Array;
        private var _buildContainer:BaseSprite;
        protected var fragmentW:uint;
        protected var fragmentH:uint;
        protected var fragmentWidth:uint;
        protected var fragmentHeight:uint;
        private var _tileByteArrays:ByteArray;
        private var _builds:Array;
        private var _roles:Array;
        private var _swfs:Array;
        private var _swfm:Array;
        private var _roofs:Array;
        private var gridLoaded:uint;
        public var bgSrc:String;
        private var _mapPos:Object;
        private var progressFun:Function;
        protected var _url:String;
        protected var _smallBg:Image;
        public static const FRAGMENT_SIZE:uint = 512;
        public static const MAP_MAPRES_PATH:String = "art/res/map/mapres/";

        public function BgGPUView()
        {
            touchable = false;
            return;
        }// end function

        public function get mapPos() : Object
        {
            return this._mapPos;
        }// end function

        public function get tileByteArrays() : ByteArray
        {
            return this._tileByteArrays;
        }// end function

        public function set tileByteArrays(param1:ByteArray) : void
        {
            this._tileByteArrays = param1;
            return;
        }// end function

        public function get swfs() : Array
        {
            return this._swfs;
        }// end function

        public function get swfm() : Array
        {
            return this._swfm;
        }// end function

        public function get roles() : Array
        {
            return this._roles;
        }// end function

        public function get builds() : Array
        {
            return this._builds;
        }// end function

        public function update(param1:String, param2:Function, param3:Function = null) : void
        {
            this.reset();
            this.gridLoaded = 0;
            this.progressFun = param3;
            registerClassAlias("PathNode", PathNode);
            this._url = param1;
            VResManager.load(this._url, this.loadBinComplete, [param2], null, null, false, true);
            return;
        }// end function

        protected function loadBinComplete(param1:ByteArray, param2:Function) : Object
        {
            if (!param1)
            {
                return null;
            }
            param1 = ToolKit.cloneObject(param1);
            param1.uncompress();
            param1.position = 0;
            _w = param1.readUnsignedInt();
            _h = param1.readUnsignedInt();
            if (_w < 1 || _h < 1)
            {
                return null;
            }
            param1.readUnsignedInt();
            param1.readUnsignedInt();
            this.fragmentWidth = FRAGMENT_SIZE;
            this.fragmentHeight = FRAGMENT_SIZE;
            this.fragmentW = param1.readUnsignedInt();
            this.fragmentH = param1.readUnsignedInt();
            var _loc_3:* = param1.readUTF();
            var _loc_4:* = param1.readObject();
            this._roles = _loc_4.roles as Array;
            this._swfs = _loc_4.swfs as Array;
            this._swfm = _loc_4.swfm as Array;
            this._builds = _loc_4.builds as Array;
            this._tileByteArrays = _loc_4.Tiles;
            this._roofs = _loc_4.roof;
            this.bgSrc = MAP_MAPRES_PATH + _loc_3.replace("\\", "/");
            this.addBg();
            this._mapPos = _loc_4.mapPos;
            if (param2 != null)
            {
                param2.call();
            }
            return _loc_4;
        }// end function

        protected function loadBinFail(param1:Function) : void
        {
            Log.log("地图bin资源加载失败");
            return;
        }// end function

        public function getRoleByCfgID(param1:uint) : Object
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._roles)
            {
                
                if (_loc_2.cfgId == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function updateWith(param1:uint, param2:uint, param3:uint, param4:uint, param5:String) : void
        {
            _w = param3 * param1;
            _h = param4 * param2;
            this.fragmentW = param3;
            this.fragmentH = param4;
            this.fragmentWidth = param1;
            this.fragmentHeight = param2;
            this.bgSrc = param5;
            this.addBg();
            move(0, 0);
            return;
        }// end function

        public function addBg() : void
        {
            var _loc_1:* = null;
            if (this.bgSrc)
            {
                Log.log("加载背景", this.bgSrc);
                _loc_1 = this.bgSrc + "/small.jpg";
                VResManager.load(_loc_1, this.loadSmallBgOK, null, this.loadSmallBgFail, this.progressFun);
            }
            return;
        }// end function

        protected function loadSmallBgOK(param1:BitmapData) : void
        {
            var _loc_2:* = Texture.fromBitmapData(param1, false);
            this._smallBg = new Image(_loc_2);
            var _loc_3:* = 16;
            this._smallBg.scaleY = 16;
            this._smallBg.scaleX = _loc_3;
            if (this.bgSrc)
            {
                this.addBgFragments();
            }
            return;
        }// end function

        private function loadSmallBgFail() : void
        {
            return;
        }// end function

        private function getFileType(param1:String) : String
        {
            var _loc_2:* = param1.split(".");
            return _loc_2[(_loc_2.length - 1)].split("?")[0];
        }// end function

        protected function addBgFragments() : void
        {
            var _loc_5:* = null;
            var _loc_7:* = 0;
            var _loc_1:* = [];
            var _loc_2:* = [];
            var _loc_3:* = [];
            var _loc_4:* = 0;
            var _loc_6:* = 0;
            while (_loc_6 < this.fragmentH)
            {
                
                _loc_7 = 0;
                while (_loc_7 < this.fragmentW)
                {
                    
                    _loc_5 = this.bgSrc + "/atf/bgfm" + _loc_4 + ".atf";
                    _loc_1.push(_loc_5);
                    _loc_2.push([_loc_4, _loc_7, _loc_6]);
                    _loc_4++;
                    _loc_7++;
                }
                _loc_6++;
            }
            VResManager.loadGroup(_loc_1, this.addOneFragmentComplete, _loc_2, this.addOneFragmentFail, null, this.addFragmentsComplete, null, false, true);
            return;
        }// end function

        protected function addOneFragmentFail(param1:int, param2:int, param3:int) : void
        {
            return;
        }// end function

        protected function addOneFragmentComplete(param1:ByteArray, param2:int, param3:int, param4:int) : void
        {
            if (param1)
            {
                this.showFragmentByATF(param1, param2, param3, param4);
            }
            return;
        }// end function

        protected function showFragmentByATF(param1:ByteArray, param2:int, param3:int, param4:int) : void
        {
            var _loc_5:* = Texture.fromAtfData(param1, 1, false);
            var _loc_6:* = new Image(_loc_5);
            _loc_6.smoothing = TextureSmoothing.NONE;
            _loc_6.blendMode = BlendMode.NONE;
            _loc_6.x = param3 * this.fragmentWidth;
            _loc_6.y = param4 * this.fragmentHeight;
            if (_loc_6.width != this.fragmentWidth)
            {
                _loc_6.width = this.fragmentWidth;
            }
            if (_loc_6.height != this.fragmentHeight)
            {
                _loc_6.height = this.fragmentHeight;
            }
            addChild(_loc_6);
            return;
        }// end function

        protected function addFragmentsComplete() : void
        {
            if (this._smallBg)
            {
                this._smallBg.removeFromParent();
                this._smallBg = null;
            }
            return;
        }// end function

        override public function finalize() : void
        {
            this.reset();
            this.progressFun = null;
            dispose();
            if (this._smallBg)
            {
                this._smallBg.removeFromParent();
                this._smallBg = null;
            }
            if (this._url)
            {
                VResManager.getInstance().cancelLoad(this._url, this.loadBinComplete);
            }
            super.finalize();
            return;
        }// end function

        override public function set x(param1:Number) : void
        {
            super.x = param1;
            return;
        }// end function

        override public function set y(param1:Number) : void
        {
            super.y = param1;
            return;
        }// end function

        protected function addBgComplete() : void
        {
            BgDrawManager.getBuildingSet(this.addBuildingSetComplete);
            return;
        }// end function

        private function addBuildingSetComplete(param1) : void
        {
            var _loc_3:* = null;
            this.builds.sortOn(["y", "x"], [Array.NUMERIC, Array.NUMERIC]);
            var _loc_2:* = [];
            for each (_loc_3 in this.builds)
            {
                
                if (_loc_2.indexOf(MAP_MAPRES_PATH + _loc_3.path) == -1)
                {
                    _loc_2.push(MAP_MAPRES_PATH + _loc_3.path);
                }
            }
            VResManager.loadGroup(_loc_2, null, null, null, null, this.paintBuilding, null, true);
            return;
        }// end function

        public function reset() : void
        {
            if (this._url)
            {
                VResManager.getInstance().cancelLoad(this._url, this.loadBinComplete);
            }
            clearChild(true);
            return;
        }// end function

        public function paintBuilding() : void
        {
            return;
        }// end function

        public function get roofs() : Array
        {
            return this._roofs;
        }// end function

    }
}
