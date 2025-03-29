# Contributing to LlamaUI

Thank you for considering contributing to LlamaUI! This document provides guidelines and instructions for contributing to this project.

## Code of Conduct

By participating in this project, you agree to abide by our [Code of Conduct](CODE_OF_CONDUCT.md).

## How Can I Contribute?

### Reporting Bugs

When reporting bugs, please include:

- A clear and descriptive title
- Steps to reproduce the issue
- Expected behavior
- Actual behavior
- Screenshots if applicable
- Environment details (OS, browser, versions)

### Suggesting Enhancements

When suggesting enhancements, please include:

- A clear and descriptive title
- A detailed description of the proposed functionality
- Any potential implementation details you might have in mind
- Why this enhancement would be useful to most users

### Pull Requests

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Development Workflow

### Setting Up Development Environment

1. Clone the repository
   ```bash
   git clone https://github.com/yourusername/llama-ui.git
   cd llama-ui
   ```

2. Set up the frontend
   ```bash
   cd frontend
   npm install
   ```

3. Set up the backend
   ```bash
   cd ../backend
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   pip install -r requirements.txt
   ```

### Testing

- Run frontend tests: `cd frontend && npm test`
- Run backend tests: `cd backend && pytest`

### Code Style

- Frontend: We use ESLint and Prettier for code formatting
- Backend: We follow PEP 8 guidelines for Python code

To check code style:
- Frontend: `cd frontend && npm run lint`
- Backend: `cd backend && flake8`

## Git Commit Guidelines

We follow conventional commits for commit messages:

- `feat:` - A new feature
- `fix:` - A bug fix
- `docs:` - Documentation only changes
- `style:` - Changes that do not affect the meaning of the code
- `refactor:` - A code change that neither fixes a bug nor adds a feature
- `test:` - Adding missing tests or correcting existing tests
- `chore:` - Changes to the build process or auxiliary tools

Example: `feat: add search highlighting feature`

## Pull Request Process

1. Ensure your code follows the style guidelines
2. Update documentation if necessary
3. Add tests for new functionality
4. Make sure all tests pass
5. Get at least one code review from a maintainer

## Release Process

Our maintainers will handle the release process following semantic versioning:

- MAJOR.MINOR.PATCH (e.g., 1.0.0)
- MAJOR: Breaking changes
- MINOR: New features, no breaking changes
- PATCH: Bug fixes, no breaking changes

## Questions?

Feel free to open an issue with your questions or contact the maintainers directly.

Thank you for contributing to LlamaUI! 