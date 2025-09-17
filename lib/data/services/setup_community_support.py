#!/usr/bin/env python3
"""
Setup script for Community Support MCP Server

This script sets up and runs the Community Support MCP Server for the QuitVaping app.
It provides community support features including peer matching, secure messaging,
AI-generated supportive responses, and milestone sharing.
"""

import os
import sys
import subprocess
import logging
from pathlib import Path

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def check_dependencies():
    """Check if required dependencies are installed"""
    required_packages = [
        'fastmcp',
        'uvicorn',
        'python-dateutil',
    ]
    
    missing_packages = []
    
    for package in required_packages:
        try:
            __import__(package.replace('-', '_'))
        except ImportError:
            missing_packages.append(package)
    
    if missing_packages:
        logger.error(f"Missing required packages: {missing_packages}")
        logger.info("Install them with: pip install " + " ".join(missing_packages))
        return False
    
    return True

def setup_environment():
    """Set up environment variables for the MCP server"""
    env_vars = {
        'MESSAGE_ENCRYPTION_KEY': 'community_support_encryption_key_2024',
        'ANONYMOUS_ID_SALT': 'quit_vaping_anonymous_salt_2024',
        'MCP_SERVER_PORT': '8001',
        'MCP_SERVER_HOST': 'localhost',
    }
    
    for key, value in env_vars.items():
        if key not in os.environ:
            os.environ[key] = value
            logger.info(f"Set environment variable: {key}")

def run_mcp_server():
    """Run the Community Support MCP Server"""
    server_path = Path(__file__).parent / 'community_support_mcp_server.py'
    
    if not server_path.exists():
        logger.error(f"MCP server file not found: {server_path}")
        return False
    
    try:
        logger.info("Starting Community Support MCP Server...")
        logger.info(f"Server will be available at http://{os.environ.get('MCP_SERVER_HOST', 'localhost')}:{os.environ.get('MCP_SERVER_PORT', '8001')}")
        
        # Run the server
        subprocess.run([
            sys.executable, 
            str(server_path)
        ], check=True)
        
    except subprocess.CalledProcessError as e:
        logger.error(f"Failed to start MCP server: {e}")
        return False
    except KeyboardInterrupt:
        logger.info("Server stopped by user")
        return True
    
    return True

def main():
    """Main setup function"""
    logger.info("Setting up Community Support MCP Server...")
    
    # Check dependencies
    if not check_dependencies():
        logger.error("Dependency check failed. Please install required packages.")
        sys.exit(1)
    
    # Setup environment
    setup_environment()
    
    # Run server
    if not run_mcp_server():
        logger.error("Failed to start MCP server")
        sys.exit(1)
    
    logger.info("Community Support MCP Server setup completed successfully!")

if __name__ == "__main__":
    main()