package com.f1.interfaces
{
    import com.f1.*;
    import com.f1.interfaces.ui.*;

    public interface IBaseScene extends IComponent
    {

        public function IBaseScene();

        function createLayer(param1:String = null) : BaseSprite;

        function getLayerByName(param1:String) : BaseSprite;

        function initScene() : void;

        function cleanScene() : void;

        function get preScene() : IBaseScene;

        function set preScene(param1:IBaseScene) : void;

        function get nextScene() : IBaseScene;

        function set nextScene(param1:IBaseScene) : void;

    }
}
