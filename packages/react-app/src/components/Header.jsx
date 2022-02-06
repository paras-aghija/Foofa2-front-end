import { PageHeader } from "antd";
import React from "react";
import "./Header.css";
import { Button, Card, Col, Menu, Row, Input } from "antd";
import { Link, useLocation } from "react-router-dom";

// displays a page header

export default function Header() {
  const location = useLocation();

  return (
    <div className="header-wrapper">
      <h1 className="heading">FooFa</h1>

      <div className="nav-menu">
        <ul className="nav-items">
          <li className="nav-item">
            <Link to="/">List NFT</Link>
          </li>
          <li className="nav-item">
            <Link to="debug">Debug</Link>
          </li>
          <li className="nav-item">
            <Link to="/hints">Buy NFT</Link>
          </li>
          <li className="nav-item">
            <Link to="/exampleui">Buy Tokens</Link>
          </li>
          <li className="nav-item">
            <Link to="/mainnetdai">Sell Tokens</Link>
          </li>
          <li className="nav-item">
            <Link to="/subgraph">Burn Tokens</Link>
          </li>
        </ul>
      </div>

      {/* <Menu style={{ textAlign: "center", marginTop: 40 }} selectedKeys={[location.pathname]} mode="horizontal">
        <Menu.Item key="/">
          <Link to="/">App Home</Link>
        </Menu.Item>
        <Menu.Item key="/debug">
          <Link to="/debug">Debug Contracts</Link>
        </Menu.Item>
        <Menu.Item key="/hints">
          <Link to="/hints">Hints</Link>
        </Menu.Item>
        <Menu.Item key="/exampleui">
          <Link to="/exampleui">ExampleUI</Link>
        </Menu.Item>
        <Menu.Item key="/mainnetdai">
          <Link to="/mainnetdai">Mainnet DAI</Link>
        </Menu.Item>
        <Menu.Item key="/subgraph">
          <Link to="/subgraph">Subgraph</Link>
        </Menu.Item>
      </Menu> */}
    </div>
  );
}
