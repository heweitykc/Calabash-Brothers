package com.f1.interfaces.manager
{
    import com.f1.interfaces.*;
    import flash.display.*;

    public interface ISceneManager
    {

        public function ISceneManager();

        function get currentScene() : IBaseScene;

        function removeScene(param1:IBaseScene, param2:Boolean = false) : void;

        function enterScene(param1:IBaseScene) : void;

        function backToPreScene(param1:IBaseScene = null) : Boolean;

        function isInScene(param1:IBaseScene) : Boolean;

        function resize() : void;

        function get container() : DisplayObjectContainer;

    }
}
