NAME	= 

CFLAGS 	= -Wall -Wextra -Werror

SRC 	= 

.PHONY: all clean fclean re

RED		=	\033[0;31m
GREEN	=	\033[0;32m
NC		=	\033[0m

OBJSFD 	= objects

OBJS 	= $(addprefix $(OBJSFD)/,$(SRC1:.c=.o))

HDR 		= -I./includes
LIBFT_HDR 	= -I./libft/includes
LIB_BINARY	= -L./libft -lft
LIBFT		= libft/libft.a

$(LIBFT):
	@make -C libft re

all: $(LIBFT) $(NAME)

$(OBJSFD):
	@mkdir $@

$(OBJSFD)/%.o: %.c | $(OBJSFD)
	@$(CC) $(CFLAGS) $(HDR) $(LIBFT_HDR) -c $< -o $@

$(NAME): $(OBJS) $(LIBFT)
	@echo "$(GREEN)compiling $@...$(NC)"
	@gcc $(CFLAGS) $(OBJS) $(LIB_BINARY) -o $@ 
	@echo "$(GREEN)$@ is ready to test$(NC)"

clean:
	@echo "$(RED)deleting object files...$(NC)"
	@/bin/rm -f $(OBJS)
	@rm -rf $(OBJSFD)
	@make -C ./libft clean

fclean: clean
	@echo "$(RED)deleting executable...$(NC)"
	@/bin/rm -f $(NAME)
	@make -C ./libft fclean

re: fclean all
