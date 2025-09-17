#!/usr/bin/env python3
"""
Setup script for Health Data MCP Server
"""

from setuptools import setup, find_packages

setup(
    name="postman-health-mcp-server",
    version="1.0.0",
    description="Health Data MCP Server for QuitVaping App using Postman tools",
    author="QuitVaping Team",
    author_email="support@quitvaping.app",
    packages=find_packages(),
    python_requires=">=3.8",
    install_requires=[
        "mcp>=0.1.0",
        "httpx>=0.24.0",
        "fastapi>=0.100.0",
        "uvicorn>=0.23.0",
        "pydantic>=2.0.0",
        "python-dotenv>=1.0.0",
        "asyncio-mqtt>=0.13.0",
        "aiofiles>=23.0.0",
    ],
    entry_points={
        "console_scripts": [
            "health-data-mcp-server=health_data_mcp_server:main",
        ],
    },
    classifiers=[
        "Development Status :: 4 - Beta",
        "Intended Audience :: Healthcare Industry",
        "License :: OSI Approved :: MIT License",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "Programming Language :: Python :: 3.11",
    ],
)