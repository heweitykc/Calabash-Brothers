package com.yy.game
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;

    public class GameMsgCollector extends Object
    {
        private var libInstance:Object = null;
        private var toCallParamsMap:Object;
        private var isIniting:Boolean = false;
        private static const SWF_LIB_URL:String = "http://client.garbage.game.yy.com/GameMsgCollectorLib.swf";
        private static const CONFIG_URL:String = "http://client.garbage.game.yy.com/v.xml";
        private static var _instance:GameMsgCollector;
        public static const VERSION:String = "3.0";

        public function GameMsgCollector(param1:PrivateClass)
        {
            this.toCallParamsMap = {};
            if (param1 == null)
            {
                throw new ArgumentError("本类是单例实现，请通过instance静态getter获取实例！");
            }
            return;
        }// end function

        public function dispose() : void
        {
            _instance = null;
            return;
        }// end function

        public function collectMessage(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String, param8:Function = null) : void
        {
            arguments = new activation;
            var paramsList:Array;
            var content:* = param1;
            var toUserRoleName:* = param2;
            var fromUserRoleName:* = param3;
            var msgType:* = param4;
            var gameSceneId:* = param5;
            var serverId:* = param6;
            var gameId:* = param7;
            var onSend:* = param8;
            var arguments:* = arguments;
            if (this.libInstance)
            {
                this.libInstance["collectMessage"].apply(this.libInstance, );
                return;
            }
            paramsList = this.toCallParamsMap["collectMessage"] || [];
            this.toCallParamsMap["collectMessage"] = ;
            this.push();
            this.initLib(function () : void
            {
                while (paramsList.length)
                {
                    
                    libInstance["collectMessage"].apply(libInstance, paramsList.shift());
                }
                return;
            }// end function
            );
            return;
        }// end function

        public function getReportable(param1:String, param2:String, param3:String, param4:String) : void
        {
            arguments = new activation;
            var paramsList:Array;
            var toUserRoleName:* = param1;
            var gameSceneId:* = param2;
            var serverId:* = param3;
            var gameId:* = param4;
            var arguments:* = arguments;
            if (this.libInstance)
            {
                this.libInstance["getReportable"].apply(this.libInstance, );
                return;
            }
            paramsList = this.toCallParamsMap["getReportable"] || [];
            this.toCallParamsMap["getReportable"] = ;
            this.push();
            this.initLib(function () : void
            {
                while (paramsList.length)
                {
                    
                    libInstance["getReportable"].apply(libInstance, paramsList.shift());
                }
                return;
            }// end function
            );
            return;
        }// end function

        public function reportGameProfile(param1:String, param2:int, param3:String, param4:String, param5:String, param6:int, param7:String, param8:GameProfileParams = null) : void
        {
            arguments = new activation;
            var paramsList:Array;
            var passport:* = param1;
            var udbid:* = param2;
            var game:* = param3;
            var gameServer:* = param4;
            var roleName:* = param5;
            var roleLevel:* = param6;
            var gameEvent:* = param7;
            var otherParams:* = param8;
            var arguments:* = arguments;
            if (this.libInstance)
            {
                this.libInstance["reportGameProfile"].apply(this.libInstance, );
                return;
            }
            paramsList = this.toCallParamsMap["reportGameProfile"] || [];
            this.toCallParamsMap["reportGameProfile"] = ;
            this.push();
            this.initLib(function () : void
            {
                while (paramsList.length)
                {
                    
                    libInstance["reportGameProfile"].apply(libInstance, paramsList.shift());
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function initLib(param1:Function) : void
        {
            var onInited:* = param1;
            if (this.isIniting)
            {
                return;
            }
            this.isIniting = true;
            this.loadConfig(function (param1:String) : void
            {
                var version:* = param1;
                if (version == null)
                {
                    isIniting = false;
                    return;
                }
                loadLibSwf(version, function (param1:Object) : void
                {
                    libInstance = param1;
                    if (libInstance)
                    {
                        onInited();
                    }
                    isIniting = false;
                    return;
                }// end function
                );
                return;
            }// end function
            );
            return;
        }// end function

        private function loadLibSwf(param1:String, param2:Function) : void
        {
            var loader:Loader;
            var onComplete:Function;
            var onIOError:Function;
            var onSecurityError:Function;
            var version:* = param1;
            var onLoaded:* = param2;
            onComplete = function (event:Event) : void
            {
                removeAllEvents();
                onLoaded(Object(loader.content)["instance"]);
                return;
            }// end function
            ;
            onIOError = function (event:IOErrorEvent) : void
            {
                removeAllEvents();
                trace("加载GameMsgCollectorLib出错，请与yy游戏相关人员联系");
                onLoaded(null);
                return;
            }// end function
            ;
            onSecurityError = function (event:SecurityErrorEvent) : void
            {
                removeAllEvents();
                trace("加载GameMsgCollectorLib出错，请与yy游戏相关人员联系");
                onLoaded(null);
                return;
            }// end function
            ;
            var removeAllEvents:* = function () : void
            {
                loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
                loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
                loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
                return;
            }// end function
            ;
            loader = new Loader();
            var request:* = new URLRequest();
            request.url = SWF_LIB_URL;
            var variables:* = new URLVariables();
            variables.v = version;
            request.data = variables;
            request.method = URLRequestMethod.GET;
            var context:* = new LoaderContext(false, ApplicationDomain.currentDomain, SecurityDomain.currentDomain);
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
            loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
            loader.load(request, context);
            return;
        }// end function

        private function loadConfig(param1:Function) : void
        {
            var loader:URLLoader;
            var onComplete:Function;
            var onIOError:Function;
            var onLoaded:* = param1;
            onComplete = function (event:Event) : void
            {
                removeAllEvents();
                var _loc_2:* = new XML(loader.data);
                onLoaded(_loc_2.v);
                return;
            }// end function
            ;
            onIOError = function (event:IOErrorEvent) : void
            {
                removeAllEvents();
                trace("加载GameMsgCollectorLib配置文件出错，请与yy游戏相关人员联系");
                onLoaded(null);
                return;
            }// end function
            ;
            var removeAllEvents:* = function () : void
            {
                loader.removeEventListener(Event.COMPLETE, onComplete);
                loader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
                return;
            }// end function
            ;
            loader = new URLLoader();
            var request:* = new URLRequest();
            request.url = CONFIG_URL;
            var variables:* = new URLVariables();
            variables.v = new Date().getTime().toString();
            request.data = variables;
            request.method = URLRequestMethod.GET;
            loader.dataFormat = URLLoaderDataFormat.TEXT;
            loader.addEventListener(Event.COMPLETE, onComplete);
            loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
            loader.load(request);
            return;
        }// end function

        public static function get instance() : GameMsgCollector
        {
            if (_instance == null)
            {
                _instance = new GameMsgCollector(new PrivateClass());
            }
            return _instance;
        }// end function

    }
}

import flash.display.*;

import flash.events.*;

import flash.net.*;

import flash.system.*;

class PrivateClass extends Object
{

    function PrivateClass()
    {
        return;
    }// end function

}

